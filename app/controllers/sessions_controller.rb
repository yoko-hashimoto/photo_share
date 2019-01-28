class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # ログインに成功した場合
      # sessionメソッドを利用してログインを行う
      session[:user_id] = user.id
      flash[:success] = 'ログインしました'
      # redirect_to user_path(user.id)
      redirect_to photos_path
    else
      # ログインに失敗した場合
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    # ログアウトの処理
    session.delete(:user_id)
    flash[:info] = 'ログアウトしました'
    redirect_to new_session_path
  end

end
