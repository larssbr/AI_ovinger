class CommentAddedNotifier < ActionMailer::Base
  default from: 'PaperSphere <papersphere2013@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_added_notifier.added.subject
  #
  def added(comment, user)
    @comment = comment
    @user = user
    mail to: @user.email, subject: 'New comment has been added.'     
  end
end
