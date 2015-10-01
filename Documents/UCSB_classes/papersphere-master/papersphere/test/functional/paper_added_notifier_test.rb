require 'test_helper'

class PaperAddedNotifierTest < ActionMailer::TestCase
  test "added" do
  	reading_list = reading_lists(:one)
  	user = users(:alice)
    mail = PaperAddedNotifier.added('alice', 'title', user, 'Reading List One')
   	assert_equal "Paper has been added to your reading list.", mail.subject
    assert_equal ["papersphere2013@gmail.com"], mail.from
  end

end
