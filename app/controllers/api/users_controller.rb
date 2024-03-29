class Api::UsersController < ApplicationController
  wrap_parameters include: User.attribute_names + ['password']
  
  def index
    @users = User.all
    render :index
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      login!(@user)
      # render json: @user
      render :show
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end
end



