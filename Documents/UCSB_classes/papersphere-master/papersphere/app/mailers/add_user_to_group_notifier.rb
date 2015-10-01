class AddUserToGroupNotifier < ActionMailer::Base
  default from: 'PaperSphere <papersphere2013@gmail.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.add_user_to_group_notifier.added.subject
  #
  def added(user, name)

      @user = user
      @name = name
      if @user.added_to_group
        mail to: @user.email, subject: 'You have been added to the group.'        
      end   
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.add_user_to_group_notifier.removed.subject
  #
  def removed(user, name)
    @user = user
    @name = name
    @greeting = "Hi"
    mail to:  @user.email, subject: 'You have been removed from the group.'
  end
end
