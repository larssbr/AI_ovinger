class ListSharedNotifier < ActionMailer::Base
   default from: 'PaperSphere <papersphere2013@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.list_shared_notifier.shared.subject
  #
  def shared(first_name, reading_list_name, user)
    @firstname = first_name
    @reading_list_name = reading_list_name
    @user = user
    mail to: @user.email, subject: 'Reading list has been shared with you.' 
  end
end
