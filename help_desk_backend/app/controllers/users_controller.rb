class UsersController < ApplicationController
  # POST /auth/register
  def register
    user = User.new(params.permit(:username, :password))

    if user.save
      user.create_expert_profile

      session[:user_id] = user.id
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
      session[:user_id] = user.id
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

  # POST /auth/refresh
  def refresh
    user_id = session[:user_id]

    if user_id.nil?
      render json: { error: "No session found" }, status: :unauthorized
      return
    end

    user = User.find_by(id: user_id)

    if user.nil?
      reset_session
      render json: { error: "No session found" }, status: :unauthorized
      return
    end

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
  end

  # GET /auth/me
  def me
    user_id = session[:user_id]

    if user_id.nil?
      render json: { error: "No session found" }, status: :unauthorized
      return
    end

    user = User.find_by(id: user_id)

    if user.nil?
      reset_session
      render json: { error: "No session found" }, status: :unauthorized
      return
    end

    render json: {
      id: user.id,
      username: user.username,
      created_at: user.created_at.iso8601,
      last_active_at: user.last_active_at&.iso8601
    }, status: :ok
  end

  private

  def generate_jwt(user)
    JwtService.encode(user)
  end
end
