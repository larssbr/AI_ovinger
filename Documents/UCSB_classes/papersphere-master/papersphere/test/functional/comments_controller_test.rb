require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  
  setup do
    login_as users(:alice)
  end
  
  def test_create_ajax_success
    assert_difference "Comment.count", 1 do
      xhr :post, :create, create_params
    end
    assert_response :success
    
    comment = assigns(:comment)
    assert_equal reading_list_papers(:one), comment.reading_list_paper
    assert_equal users(:alice), comment.author
    assert_equal "first!", comment.text
  end
  
  private
  
  def create_params
    {
      :reading_list_paper_id => reading_list_papers(:one).id,
      :comment => { :text => "first!" }
    }
  end
  
end
