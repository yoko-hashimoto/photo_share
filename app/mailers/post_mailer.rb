class PostMailer < ApplicationMailer

  def post_mail(photo) # post_mail(photo)で引数の値を受け取っている
    # @photoとする事でViewファイルにphotoの情報を渡すことができる
    @photo = photo
    # to:で送り先 → photoを投稿した人のアドレス、subject:で件名を設定
    mail to: "#{@photo.user.email}", subject: "投稿確認メール"
  end
end
