class EventsController < ApplicationController
  before_action :authorize_request
  before_action :set_event, only: [:show, :update, :destroy]
  before_action -> { authorize_user(['admin', 'manager']) },
    only: [:create, :destroy]

  # GET /events
  def index
    @events = Event.all.order(created_at: :desc)

    render json: @events.to_json(:include => [:user, :inscriptions]), status: :ok
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
    render json: @event
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

  # PATCH/PUT /events/1
  def update
    if @event.update(event_params)
      render json: @event
    else
      render json: { errors: @event.errors }, status: :unprocessable_entity
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
      params.require(:event).permit(:name, :description, :areas, :active, :status, :file, :need_additional)
    end
end
