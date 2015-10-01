require 'test_helper'

class RatingsControllerTest < ActionController::TestCase
  
  setup do
    login_as users(:alice)
  end
  
  def test_create_ajax_success
    assert_difference "Rating.count", 1 do
      xhr :post, :create, create_params
    end
    assert_response :success
    
    actual_rating = assigns(:rating)
    assert_equal reading_list_papers(:two), actual_rating.reading_list_paper
    assert_equal users(:alice), actual_rating.user
    assert_equal 5, actual_rating.value
  end
  
  def test_create_success
    assert_difference "Rating.count", 1 do
      post :create, create_params
    end
    assert_redirected_to reading_list_paper_path reading_list_papers(:two)

    actual_rating = assigns(:rating)    
    assert_equal reading_list_papers(:two), actual_rating.reading_list_paper
    assert_equal users(:alice), actual_rating.user
    assert_equal 5, actual_rating.value
  end
  
  def test_update_ajax_success
    xhr :post, :update, update_params
    assert_response :success
    
    actual_rating = assigns(:rating)
    assert_equal ratings(:one), actual_rating
    assert_equal 3, actual_rating.value
  end
  
  def test_update_success
    post :update, update_params
    assert_redirected_to reading_list_paper_path ratings(:one).reading_list_paper
    
    actual_rating = assigns(:rating)
    assert_equal ratings(:one), actual_rating
    assert_equal 3, actual_rating.value
  end
  
  private
  
  def create_params
    {
      :reading_list_paper_id => reading_list_papers(:two).id,
      :user_id => users(:alice).id,
      :rating => {
        :value => 5
      }
    }
  end
  
  def update_params
    {
      id: ratings(:one).id,
      reading_list_paper_id: ratings(:one).reading_list_paper.id,
      rating: {
        value: 3
      }
    }
  end
  
end
