class ReadingListShare < ActiveRecord::Base
  belongs_to :group
  belongs_to :reading_list
  attr_accessible :access_rights, :group_id, :reading_list_id

  ACCESS_RIGHTS = [ 'owner', 'readwrite', 'readonly', 'none' ]
  validates :access_rights, :inclusion => ACCESS_RIGHTS
end
