class Favorite < ApplicationRecord
  # お気に入りは1人のuserに属している
  belongs_to :user
  # お気に入りは１つのphotoに属している
  belongs_to :photo
end
