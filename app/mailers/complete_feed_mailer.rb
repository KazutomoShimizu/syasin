class CompleteFeedMailer < ApplicationMailer
  def complete_mail(complete)
    @complete = complete

    mail to: @complete.email, subject: "投稿完了のお知らせ"
  end
end
