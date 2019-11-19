class InscriptionsController < ApplicationController
  before_action :authorize_request
  before_action :set_inscription, only: [:destroy]

  # POST /inscriptions
  def create
    incription = Inscription.where(inscription_params)

    if incription.empty?
      @inscription = Inscription.new(inscription_params)
      if @inscription.save
        render json: @inscription, status: :created
      else
        render json: { errors: @inscription.errors.full_messages },
               status: :unprocessable_entity
      end
    else
      render json: { errors: ['Inscrição já foi feita nesse evento'] }, status: :unprocessable_entity
    end
    return
  end

  # DELETE /inscriptions/1
  def destroy
    @inscription.destroy
  end

  private
    def set_inscription
      @inscription = Inscription.find(params[:id])
    end

    def inscription_params
      params.require(:inscription).permit(:user_id, :event_id)
    end
end
