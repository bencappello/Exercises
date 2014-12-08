class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    @user.password = params[:user][:password]
    if @user.save!
      #login!(@user)
      redirect_to users_url
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :session_token)
  end

end
