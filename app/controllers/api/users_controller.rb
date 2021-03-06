class Api::UsersController < ApplicationController
  def index
    @users = Users.all
    render :index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render :show
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def register_token 
    @user = current_user
    if @user
      render :show 
    else 
      render json: { id: nil, email: nil, phone_number: nil }
    end  
  end 

  private

  def user_params
    params.require(:user).permit(:email, :phone_number, :password)
  end
end
