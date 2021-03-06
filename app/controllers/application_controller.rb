class ApplicationController < ActionController::API
  def not_found
    render json: { errors: [ 'Resource not found' ] }, status: :not_found
  end

  #TODO Refactor later
  def extract_user
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      @current_user = nil
    rescue JWT::DecodeError => e
      @current_user = nil
    end

    @current_user
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def authorize_user(permissions)
    begin
      if !@current_user
        self.authorize_request
      end

      is_authorized = permissions.include? @current_user[:role]

      raise "NoPermission" if !is_authorized
    rescue RuntimeError, NoMethodError => e
      render json: { errors: [ 'Você não tem permissão para essa operação' ] }, status: :unauthorized
    end
  end
end
