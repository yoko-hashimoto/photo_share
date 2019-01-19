class PostMailer < ApplicationMailer

  def post_mail(photo)
    @photo = photo
   
    # mail to: "#{@photo.user.email}", subject: "投稿確認メール"
    mail to: "yoko.hashimoto.29@gmail.com", subject: "投稿確認メール"
  end

end
