class UsersController < ApplicationController
  before_action :user_check, only: [:edit, :destroy]

  def new
    if params[:back]
      @user = User.new(user_params)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # サインアップと同時にログイン状態にする
      session[:user_id] = @user.id
      flash[:success] = "アカウント登録が完了しました！"
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    set_user
  end

  def edit
    set_user
  end

  def update
    set_user
    if @user.update(user_params)
      flash[:info] = "Profileを編集しました！"
      redirect_to user_path(current_user.id)

    else
      render 'edit'
    end
  end

  def confirm
    # # ログイン中のユーザーを、build(new)する
    # @user = current_user.build(user_params)

    # # 確認画面(confirm)を挟む時は手動でバリデーションの設定が必要
    # # バリデーションに失敗した時は入力フォームを再描画する。
    # render :new if @user.invalid?
  end

  def destroy
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :icon_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_check
    set_user
      unless @user.id == current_user.id
        flash[:danger] = "アクセス権限がありません。"
        redirect_to photos_path
      end
  end

end