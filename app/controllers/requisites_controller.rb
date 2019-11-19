class RequisitesController < ApplicationController
  before_action :authorize_request
  before_action -> { authorize_user(['admin', 'manager']) },
    only: [:create]

  # GET /requisites
  def index
    @requisites = Requisite.all

    render json: @requisites, status: :ok
  end

  # POST /requisites
  def create
    @requisite = Requisite.new(requisite_params)

    if @requisite.save
      render json: @requisite, status: :created
    else
      render json: { errors: @requisite.errors }, status: :unprocessable_entity
    end
  end

  # POST /requisites/1/event/1/
  def create_requisite_event
    @requisite_event = RequisiteEvent.new(requisite_event_params)

    @requisite_event.event_id = params[:event_id]
    @requisite_event.requisite_id = params[:id]

    if @requisite_event.save
      render json: @requisite_event, status: :created
    else
      render json: { errors: @requisite_event.errors }, status: :unprocessable_entity
    end
  end

  private
    def requisite_params
      params.require(:requisite).permit(:name, :description)
    end

    def requisite_event_params
      params.permit(:weight)
    end
end
