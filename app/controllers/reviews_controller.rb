class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)

    if @review.save
      render json: @review, status: :created
    else
      render json: { errors: @review.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private
    def review_params
      params.permit(:value, :weight, :user_id, :event_id, :requisite_id, :name)
    end
end
