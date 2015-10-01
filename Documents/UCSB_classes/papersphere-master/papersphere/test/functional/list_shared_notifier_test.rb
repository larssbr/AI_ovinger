require 'test_helper'

class ListSharedNotifierTest < ActionMailer::TestCase
  test "shared" do
  	group = groups(:one)
  	user = users(:alice)
    mail = ListSharedNotifier.shared('alice', 'one', user)
   	assert_equal "Reading list has been shared with you.", mail.subject
    assert_equal ["papersphere2013@gmail.com"], mail.from
  end

end
