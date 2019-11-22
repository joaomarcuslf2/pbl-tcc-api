class EventsController < ApplicationController
  before_action :authorize_request
  before_action :set_event, only: [:show, :update, :destroy, :audit_finish]
  before_action -> { authorize_user(['admin', 'manager']) },
    only: [:create, :destroy, :audit_finish]

  # GET /events
  def index
    @events = Event.where(active: true).order(created_at: :desc)

    render json: @events.to_json(:include => [
      :user,
      :inscriptions,
    ]), status: :ok
  end

  # GET /events/area/:areaName
  def get_by_area
    @events = Event.where("areas like ?", "%#{params[:areaName]}%").order(created_at: :desc)

    if !@events.empty?
      render json: @events, status: :ok
    else
      render json: { errors: ["Não há eventos dentro da busca"] }, status: :bad_request
    end
  end

  # GET /events/1
  def show
    render json: @event.to_json(:include => [
      :user,
      {
        requisite_events: {
          include: [
            :requisite
          ]
        }
      },
      {
        groups: {
          include: [
            inscriptions: {
              include: [
                :user
              ]
            }
          ]
        }
      },
      {
        inscriptions: {
          include: [
            :user
          ]
        }
      },
    ]), status: :ok
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    user = self.extract_user

    if user && user.id
      @event.user_id = user.id

      if @event.save
        render json: @event, status: :created, location: @event
      else
        render json: { errors: @event.errors }, status: :unprocessable_entity
      end
    else
      render json: { errors: ["Não foi possível encontrar o usuário"] }, status: :unprocessable_entity
    end
  end

  # POST /events/1/audit-finish
  def audit_finish
    processed_inscriptions = GroupService.new(@event.inscriptions)

    processed_inscriptions.computed.each { |g|
      group = Group.new({
        rate: g.rate,
        event_id: @event.id
      })

      if group.save
        g.members.each { |inscription|
          inscription.group_id = group.id
          inscription.save
        }
      else
        render json: { errors: group.errors }, status: :unprocessable_entity
      end
    }

    @event.status = 'started'

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: { errors: @event.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: { errors: @event.errors }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /group/1
  def update_group
    @group = Group.find(params[:id])

    if @group.update(group_params)
      render json: @group
    else
      render json: { errors: @group.errors }, status: :unprocessable_entity
    end
  end


  # DELETE /events/1
  def destroy
    user = self.extract_user

    if user && (user.role == 'admin' || user.id == @event.user_id)
      @event.destroy
    else
      render json: { errors: ["O evento não pertence ao usuário ativo"] }, status: :unprocessable_entity
    end
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :description, :areas, :active, :status, :file, :need_additional, :end_date)
    end

    def group_params
      params.permit(:file, :sent, :reviewed)
    end
end
