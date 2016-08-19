class UsersController < ApplicationController

  def splash
    render :splash
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "You successfully created new user!"
      redirect_to user_path(current_user)
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    if @user.id == current_user.id
      @posts = Post.where(user_id: params[:id])
      render :show
    else
      redirect_to user_path(current_user)
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :current_city, :image)
  end
end
