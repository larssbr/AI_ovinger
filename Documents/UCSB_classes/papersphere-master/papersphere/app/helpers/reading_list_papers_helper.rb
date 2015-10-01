module ReadingListPapersHelper
  
  def rating_to_use_for_form
    if rating = @reading_list_paper.ratings.select { |r| r.user_id == current_user.id }.first
      rating
    else
      current_user.ratings.new
    end
  end
  
  def current_user_rating
    if rating = @reading_list_paper.ratings.select { |r| r.user_id == current_user.id }.first
      rating.value
    else
      "N/A"
    end
  end
  
end
