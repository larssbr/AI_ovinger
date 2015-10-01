require 'test_helper'

class CommentAddedNotifierTest < ActionMailer::TestCase
  test "added" do
  	comment = comments(:one)
  	user = users(:alice)
    mail = CommentAddedNotifier.added(comment, user)
   	assert_equal "New comment has been added.", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["papersphere2013@gmail.com"], mail.from
  end

end
