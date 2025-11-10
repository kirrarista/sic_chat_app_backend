class ApplicationController < ActionController::API
  private

  def authenticate_user!
    user_id = session[:user_id]

    if user_id
      @current_user = User.find_by(id: user_id)
      return if @current_user
      reset_session
    end

    auth_header = request.headers["Authorization"]
    if auth_header && auth_header.start_with?("Bearer ")
      token = auth_header.split(" ").last
      payload = JwtService.decode(token)

      if payload
        @current_user = User.find_by(id: payload[:user_id])
        return if @current_user
      end
    end

    render json: { error: "Unauthorized" }, status: :unauthorized
  end

  def current_user
    @current_user
  end
end
