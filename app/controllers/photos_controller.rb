class PhotosController < ApplicationController

  before_action :set_photo, only: [:show, :edit, :update, :destroy]

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
    @photo = Photo.new(photo_params)

    # @photo.saveがバリデーションに許された（成功した）時
    if @photo.save
      # 一覧画面へ遷移して"写真を投稿しました！"とメッセージを表示する。
      redirect_to photos_path, notice: "写真を投稿しました！"
    else
      # @photo.saveがバリデーションに許されなかった（失敗した）時
      # 入力フォームを再描画する。
      render 'new'
    end
  end

  def confirm
    @photo = Photo.new(photo_params)
    # 確認画面(confirm)を挟む時は手動でバリデーションの設定が必要
    # バリデーションに失敗した時は入力フォームを再描画する。
    render :new if @photo.invalid?
    end

  def edit
  end

  def show
    set_photo
  end

  def update
    if @photo.update(photo_params)
      redirect_to photos_path, notice: "Photoを編集しました！"
    else
      render 'edit'
    end

  end

  def destroy
    @photo.destroy
    redirect_to photos_path, notice:"Photoを削除しました！"
  end

  private

  def photo_params
    params.require(:photo).permit(:caption, :image, :image_cache)
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

end
