class Rating < ActiveRecord::Base
  
  belongs_to :reading_list_paper
  belongs_to :user
  
  attr_accessible :value
  
  validates_presence_of :value, :user, :reading_list_paper
  
  validates_inclusion_of :value, in: [1, 2, 3, 4, 5]
  
  validate :only_one_rating_per_user_per_reading_list_paper
  
  private
  
  def only_one_rating_per_user_per_reading_list_paper
    rating = Rating.where(:user_id => user_id, :reading_list_paper_id => reading_list_paper_id)
    if rating.present? && (rating.size > 1 || self != rating.first)
      errors.add(:base, "can only be created once per user, per reading list paper")
    end
  end

end
