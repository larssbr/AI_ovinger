require 'test_helper'

class RatingTest < ActiveSupport::TestCase
  
  def test_should_validate_presence_of
    Rating.destroy_all
    
    r = Rating.new
    r.value = nil
    r.user = nil
    r.reading_list_paper = nil
    assert_equal false, r.valid?
    
    r.value = 3
    assert_equal false, r.valid?
    
    r.user = users(:alice)
    assert_equal false, r.valid?
    
    r.reading_list_paper = reading_list_papers(:one)
    assert r.valid?
  end
  
  def test_should_validate_inclusion_of_value
    r = ratings(:one)
    assert r.valid?
    
    r.value = 6
    assert_equal false, r.valid?
    assert_equal 1, r.errors.size
    assert_equal "is not included in the list", r.errors.first[1]
  end
  
  def test_should_only_create_one_rating_per_user_per_reading_list_paper
    saved_rating = ratings(:one)
    new_rating = Rating.new(:value => 3)
    new_rating.user = saved_rating.user
    new_rating.reading_list_paper = saved_rating.reading_list_paper
    
    assert_equal false, new_rating.valid?
    assert_equal 1, new_rating.errors.size
    assert_equal "can only be created once per user, per reading list paper", new_rating.errors.first[1]
  end
  
end
