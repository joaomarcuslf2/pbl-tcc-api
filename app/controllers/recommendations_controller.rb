class RecommendationsController < CrudController
  before_action :authorize_request

  def create
    @recommendations = Recommendation.where(author: params[:author])
    @user = User.find_by_username!(params[:author])
    @recommendation = Recommendation.new(recommendation_params)

    if @recommendation.save
      if (@recommendations.length == 0 && @user.rate == "user")
        @user.rate += 150

        @user.save
      end

      render json: @recommendation, status: :created
    else
      render json: { errors: @recommendation.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def get_by_author
    @recommendations = Recommendation.where(author: params[:username])

    render json: @recommendations.to_json(include: [ :user, :requisite, :event ]), status: :ok
  end

  private
    def recommendation_params
      params.permit(:user_id, :event_id, :requisite_id, :author)
    end
end
