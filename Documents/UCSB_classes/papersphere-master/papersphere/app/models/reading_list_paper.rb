class ReadingListPaper < ActiveRecord::Base
  
  belongs_to :reading_list
  belongs_to :paper
  
  has_many :comments
  has_many :recent_comments,
    class_name: "Comment",
    order: "created_at DESC",
    limit: 10
    
  has_many :ratings
  
  attr_accessible :paper_id, :reading_list_id

  def self.reading_list_paper_for(reading_list_id, paper_id)
    ReadingListPaper.where(reading_list_id: reading_list_id, paper_id: paper_id)[0]
  end
  
  def average_rating
    return nil if ratings.empty?
    
    value = 0
    ratings.each do |rating|
      value += rating.value
    end
    total = ratings.size
    (value.to_f / total.to_f).round 3
  end
  
  def global_rating
    paper.average_rating
  end
  
end
