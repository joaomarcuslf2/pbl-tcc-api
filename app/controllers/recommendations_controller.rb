class RecommendationsController < ApplicationController
  def create
    @recommendaion = Recommendation.new(recommendaion_params)

    if @recommendaion.save
      render json: @recommendaion, status: :created
    else
      render json: { errors: @recommendaion.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private
    def recommendaion_params
      params.permit(:user_id, :event_id, :requisite_id, :author)
    end
end
