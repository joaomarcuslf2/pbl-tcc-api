class ReviewsController < CrudController
  before_action :authorize_request
  before_action -> { authorize_user(['admin', 'manager']) },
    only: [:create]

  def create
    @review = Review.new(review_params)

    if @review.save
      render json: @review, status: :created
    else
      render json: { errors: @review.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def get_by_user_and_event
    @reviews = Review.where(review_params)

    if @reviews.length > 0
      render json: @reviews.to_json(include: [
        :event,
        {
          requisite: {
            include: [
              :pills
            ]
          }
        }
      ]), status: :ok
    else
      render json: { errors: "Não possui revisões" },
             status: :not_found
    end
  end

  private
    def review_params_serach
      params.permit(:user_id, :event_id)
    end

    def review_params
      params.permit(:value, :weight, :user_id, :event_id, :requisite_id, :name)
    end
end
