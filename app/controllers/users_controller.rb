class UsersController < CrudController
  before_action :authorize_request, except: :create
  before_action :find_user, except: %i[create index update_rate]
  before_action -> { authorize_user(['admin', 'manager']) },
    only: [:index, :update_rate]

  before_action -> { authorize_user(['admin', 'manager', 'user']) },
    only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user.to_json(:include => [:events, :inscriptions, {
      reviews: { include: [ :event, :requisite ]}
    },
    {
      recommendations: { include: [ :event, :requisite ]}
    }]), status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # POST /users/1/rate/1
  def update_rate
    @user = User.find(params[:id])

    id = params[:id]
    event_id = params[:event_id]
    rate = params[:rate]

    reviews = Review.where(event_id: event_id, user_id: id)
    weights = 0
    values = 0

    reviews.each { |review|
      values += review.value * (review.weight || 1)
      weights += (review.weight || 1)
    }

    obj = RateService.new(@user.rate, rate)

    ra = @user.rate || 1200
    po = obj.points_acquired
    pe = (@user.rate - rate) > 0 ? 10 : -10
    pr = values/weights

    r = ra + 10*(po+pe) + pr

    # R = ra + 10*(po-pe) + pr, onde:
    #   R: pontuação atual
    #   Ra: pontuação anterior
    #   Po: pontos obtidos
    #   Pe: pontos esperados
    #   Pr: Pontuação por critérios de avaliação - a média ponderada de todos os critérios de avaliação que aquele evento tiver.

    @user.rate = r

    unless @user.save
      render json: { errors: @user.errors.full_messages },
            status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    unless @user.update(user_update_params)
      render json: { errors: @user.errors.full_messages },
            status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: ['Usuário não encontrado'] }, status: :not_found
  end

  def user_params
    params.permit(
      :name, :username, :email, :password, :password_confirmation
    )
  end

  def user_update_params
    params.permit(
      :avatar, :name, :username, :email, :password, :password_confirmation, :role
    )
  end
end
