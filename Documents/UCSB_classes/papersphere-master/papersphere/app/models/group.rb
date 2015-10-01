class Group < ActiveRecord::Base
  belongs_to :owner, :class_name => 'User'
  has_many :group_members, :dependent => :destroy
  has_many :reading_list_shares, :dependent => :destroy
  has_many :reading_lists, :through => :reading_list_shares
  has_many :users, :through => :group_members
  attr_accessible :name

  validates :name, :presence => true

  def has_member(email)
    group_members.each { |member|
      if member.user.email == email
        return true
      end
    }
    false
  end
end
