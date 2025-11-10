class UsersController < ApplicationController
  # POST /auth/register
  def register
    user = User.new(user_params)

    if user.save
      token = generate_jwt(user)

      render json: {
        user: {
          id: user.id,
          username: user.username,
          created_at: user.created_at.iso8601,
          last_active_at: user.last_active_at&.iso8601
        },
        token: token
      }, status: :created
    else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /auth/login
  def login
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      token = generate_jwt(user)
      
      render json: {
        user: {
          id: user.id,
          username: user.username,
          created_at: user.created_at.iso8601,
          last_active_at: user.last_active_at&.iso8601
        },
        token: token
      }, status: :ok
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  # POST /auth/logout
  def logout
    reset_session

    render json: { message: "Logged out successfully" }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def generate_jwt(user)
    "jwt_token_placeholder"
  end
end
