class PaperAddedNotifier < ActionMailer::Base
  default from: 'PaperSphere <papersphere2013@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.paper_added_notifier.added.subject
  #
  def added(first_name, paper_title, user, reading_list_name)
    @first_name = first_name
    @title = paper_title
    @user = user
    @reading_list_name = reading_list_name
    # send an email to each member of the reading list   
    mail to: @user.email, subject: 'Paper has been added to your reading list.' 
   
  end
end
