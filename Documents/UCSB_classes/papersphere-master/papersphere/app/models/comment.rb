class Comment < ActiveRecord::Base
  belongs_to :reading_list_paper
  belongs_to :author, class_name: "User"
  
  attr_accessible :text
  
  validates_presence_of :text, :author, :reading_list_paper
  
  def time_to_display
    time = if updated_at > created_at
             updated_at.in_time_zone
           else
             created_at.in_time_zone
           end
    time.strftime("%A, %B #{time.day.ordinalize} at %-I:%M%P")
  end

  def to_yaml_properties(wrap = true)
    if wrap
      self.class.new.to_yaml_properties(false)
    else
      super()
    end
  end
  
end
