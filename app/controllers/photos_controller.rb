class PhotosController < ApplicationController
  # アクションのメソッドが実行される前に実行する。
  # onlyオプションを使用することで、指定されたアクションが実行された場合のみbefore_actionメソッドを実行する。
  before_action :login_check, only: [:new, :edit, :show, :destroy]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]
  before_action :user_check, only: [:edit, :destroy]

  def index
    @photos = Photo.all.order(updated_at: "DESC")
  end

  def new
    if params[:back]
      @photo = Photo.new(photo_params)
    else
      @photo = Photo.new
    end
  end

  def create
    # ログイン中のユーザーのphotoを、build(new)する
    @photo = current_user.photos.build(photo_params)

    # @photo.saveがバリデーションに許された（成功した）時
    if @photo.save

      PostMailer.post_mail(@photo).deliver  ##追記
      redirect_to letter_opener_web_path, notice: 'Contact was successfully created.' and return

      # 一覧画面へ遷移して"写真を投稿しました！"とメッセージを表示する。
      flash[:notice] = "Photoを投稿しました！"
      redirect_to photos_path
    else
      # @photo.saveがバリデーションに許されなかった（失敗した）時
      # 入力フォームを再描画する。
      render 'new'
    end
  end

  def confirm
    # ログイン中のユーザーのphotoを、build(new)する
    @photo = current_user.photos.build(photo_params)

    # 確認画面(confirm)を挟む時は手動でバリデーションの設定が必要
    # バリデーションに失敗した時は入力フォームを再描画する。
    render :new if @photo.invalid?
    end

  def show
    set_photo
    # 今ログインしているユーザーがお気に入り登録している全レコード(user_id と photo_id)を抽出し、
    # そのphotoのidが存在しているか確認
    @favorite = current_user.favorites.find_by(photo_id: @photo.id)
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      flash[:notice] = "Photoを編集しました！"
      redirect_to photos_path
    else
      render 'edit'
    end

  end

  def destroy
    @photo.destroy
    flash[:notice] = "Photoを削除しました！"
    redirect_to photos_path
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image, :image_cache)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def login_check
    # current_userが存在していなければ、強制的にログイン画面にリダイレクト
		unless logged_in?
			flash[:alert] = "ログインしてください"
			redirect_to new_session_path
		end
  end

  def user_check
    set_photo
      # photoを投稿したuserのidと今ログインしているuserのidが一致するか確認し、一致しなければ
      unless @photo.user_id == current_user.id
        flash[:alert] = "アクセス権限がありません"
        # 編集画面を再描画する
        render 'edit'
      end
  end

end
