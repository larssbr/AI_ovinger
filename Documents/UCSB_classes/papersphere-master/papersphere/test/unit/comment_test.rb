require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def test_should_validate_presence_of
    c = Comment.new
    c.text = nil
    c.author = nil
    c.reading_list_paper = nil
    
    assert_equal false, c.valid?
    assert_equal 3, c.errors.size
    
    c.text = "First!"
    assert_equal false, c.valid?
    assert_equal 2, c.errors.size
    
    c.author = users(:alice)
    assert_equal false, c.valid?
    assert_equal 1, c.errors.size
    
    c.reading_list_paper = reading_list_papers(:one)
    assert c.valid?
  end
  
end
