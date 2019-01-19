module SessionsHelper
  
  # ユーザーがログインしていればtrue、その他ならfalseを返すメソッドを定義
  def logged_in?
    current_user.present?
  end

  def current_user
    # ログイン中のユーザを取得する
    # @current_user || @current_user = User.find_by(id: session[:user_id])と同じ意味
    # @current_userが真の場合はそのままにし、偽の場合は右辺の値 User.find_by(id: session[:user_id]) を代入する
    @current_user ||= User.find_by(id: session[:user_id])
  end

end
