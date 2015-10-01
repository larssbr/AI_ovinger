class Paper < ActiveRecord::Base
  has_many :reading_list_papers, :dependent => :destroy
  has_many :reading_lists, :through => :reading_list_papers
  attr_accessible :author, :publication, :title, :url, :year, :paper_code

  validates :title, :author, :year, :publication, :paper_code, :presence => true
  
  def average_rating
    all_ratings = []
    ReadingListPaper.includes(:ratings).where(:paper_id => id).all.each do |rlp|
      rlp.ratings.each do |r|
        all_ratings << r
      end
    end
    return nil if all_ratings.empty?
    
    value = 0
    all_ratings.each do |rating|
      value += rating.value
    end
    total = all_ratings.size
    (value.to_f / total.to_f).round 3
  end
  
end
