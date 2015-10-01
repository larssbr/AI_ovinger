require 'test_helper'

class AddUserToGroupNotifierTest < ActionMailer::TestCase
  test "added" do
		user = users(:alice)
		group = groups(:one)
    mail = AddUserToGroupNotifier.added(user, group)
    assert_equal "You have been added to the group.", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["papersphere2013@gmail.com"], mail.from
  end

  test "removed" do
		user = users(:bob)
		group = groups(:two)
    mail = AddUserToGroupNotifier.removed(user, group)
    assert_equal "You have been removed from the group.", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["papersphere2013@gmail.com"], mail.from
  end
end
