class ApplicationController < ActionController::API

  def render_result
    if result[:error]
      render json: { error: result[:error] }, status: result[:code]
    else
      render json: result
    end
  end

  def autorize_request
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

  def user_autenticated
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    @decoded = JsonWebToken.decode(header)
    @user = User.find(@decoded[:user_id])
  end

end
