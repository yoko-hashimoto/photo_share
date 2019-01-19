class User < ApplicationRecord

  has_secure_password

  before_validation { email.downcase! }

  validates :password, presence: true, length: { minimum: 6 }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :icon, presence: true
  #validates :icon_cache, presence: true

  # userは複数のphotoと紐づいている
  has_many :photos
  # １人のユーザは多数のphotoをお気に入りできる
  has_many :favorites, dependent: :destroy
  # favorite_photos により、 userのidと一致するuser_idを持つfavoritesテーブルのレコードを全て取りだし、
  # そのfavoritesテーブルのレコードがもっているuser_idの数字と同じidを持つphotoの情報を全件取得できる
  has_many :favorite_photos, through: :favorites, source: :photo

  # Userモデルのiconカラムに、IconUploaderを紐付ける。
  mount_uploader :icon, IconUploader
end