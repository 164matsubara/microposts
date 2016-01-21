class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :check, only: [:edit]
  
  def show #追加
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user #ここを追加
    else
      render 'new'
    end
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user , notice: 'プロフィールを更新しました'
    else
      redirect_to edit_user_path
      flash[:danger] = 'パスワードが一致しません'
    end
  end
  
  def edit
  end
  
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :profile, :area)
  end
  
  def check
    if current_user != User.find(params[:id])
      redirect_to root_path
      flash[:danger] = '正しいIDでログイン後編集してください'
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
