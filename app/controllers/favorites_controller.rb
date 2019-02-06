class FavoritesController < ApplicationController
  def create

    # 現在ログイン中のユーザーがお気に入り登録している全レコード（user_idとphoto_idの入ったFavoriteのレコード）を抽出し、
    # 全抽出したFavoriteのレコードの中に、このphotoのidが存在していれば、そのFavoriteのレコード（user_idとphoto_id）をfavoriteに代入する
    favorite = current_user.favorites.create(photo_id: params[:photo_id])
    @favorite_photo = Photo.find(favorite[:photo_id])
    # photoの詳細画面に遷移する
    redirect_to photo_path(@favorite_photo.id), info: "#{favorite.photo.user.name}さんのPhotoをお気に入り登録しました!"
    # redirect_to photos_url, では一覧画面に遷移する
    # redirect_to photos_url, notice: "#{favorite.photo.user.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    @photo = Photo.find(favorite[:photo_id])
    # photoの詳細画面に遷移する
    redirect_to photo_path(@photo.id), info: "#{favorite.photo.user.name}さんのPhotoをお気に入り解除しました!"
  end

  def index
    # 今ログインしているユーザーの、お気に入り登録しているphotoを取得し、降順に並べ替える
    @favorite_photos = current_user.favorite_photos.order(updated_at: "DESC")
  end
end
