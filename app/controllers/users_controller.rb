class UsersController < ApplicationController
before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update]


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     redirect_to user_path(@user.id)
  #   else
  #     render 'new'
  #   end
  # end

  def index
      @user = current_user
      @books = @user.books
      @book = Book.new
      @users = User.all
  end




  private


  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end


  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end




end