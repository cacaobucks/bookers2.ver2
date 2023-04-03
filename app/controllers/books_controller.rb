class BooksController < ApplicationController
before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update]
  def new# 新規作成画面を表示する処理
    @book = Book.new
  end


  def create# 新規作成をする処理
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @user = current_user
      @users = User.all
      @books = Book.all  # 投稿一覧を再取得する
      render :index  # 投稿一覧と新規投稿フォームを表示する
    end
  end


  def index# 一覧表示する処理
    @books = Book.all
    @user = current_user
    @book = Book.new
  end


  def show# 詳細表示する処理
    @book = Book.find(params[:id])
    @user = @book.user
    # @books = @user.books
    @book_new = Book.new
    @book_comment = BookComment.new
  end


  def update
    @book = Book.find(params[:id])
  if @book.update(book_params)
    redirect_to book_path, notice: "Book was successfully creatred."
  else
    render :edit
  end

  end



  def edit
    @book = Book.find(params[:id])
  end


  def destroy# 削除する処理
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

 # 投稿データのストロングパラメータ
  private



  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
      redirect_to books_path
    end
  end


  def book_params
    params.require(:book).permit(:title, :body)
  end

end
