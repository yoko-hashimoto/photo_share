class User < ApplicationRecord

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  # userは複数のphotoと紐づいている
  has_many :photos

  # Userモデルのiconカラムに、IconUploaderを紐付ける。
  mount_uploader :icon, IconUploader
end
