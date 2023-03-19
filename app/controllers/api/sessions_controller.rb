class Api::SessionsController < ApplicationController

  def show
    if current_user
      @user = current_user
      # render 'api/users/show'
      render json: { user: @user } 
    else
      render json: { user: nil }
    end
  end

  def create
    debugger
    @user = User.find_by_credentials(params[:username], params[:password])

    if @user
        login!(@user)
        render json: { user: @user } 
        # render 'api/users/show'
      else
        render json: { errors: ['The provided credentials were invalid.']}, status: 422
    end
  end

  def destroy
      logout!
      render json: { message: 'success' }
  end
end
