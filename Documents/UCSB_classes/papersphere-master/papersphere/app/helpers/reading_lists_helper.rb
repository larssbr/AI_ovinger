module ReadingListsHelper
  
  OWNER = :access_owner
  READWRITE = :access_readwrite
  READONLY = :access_readonly
  NONE = :access_none

  def self.get_shared_lists(user)
    groups = user.groups.all
    return [] if groups.empty?
    
    group_ids = []
    groups.each do |group|
      group_ids << group.id
    end    
    ReadingList.find_by_sql("SELECT `reading_lists`.* FROM `reading_lists` INNER JOIN `reading_list_shares` ON `reading_lists`.`id` = `reading_list_shares`.`reading_list_id` WHERE `reading_list_shares`.`group_id` IN (#{group_ids.join(',')})")
  end
  
  def self.has_access(reading_list, user, requested_access_rights)
    access_rights = get_shared_list_access_rights(reading_list, user)
    
    if requested_access_rights == OWNER
      if access_rights == OWNER
        return true
      end
      return false
    end
    
    if requested_access_rights == READWRITE
      if access_rights == OWNER or
         access_rights == READWRITE
        return true
      end
      return false
    end
    
    if requested_access_rights == READONLY
      if access_rights == OWNER or
         access_rights == READWRITE or
         access_rights == READONLY
        return true
      end
      return false
    end
    
    if requested_access_rights == NONE
      return true
    end
    
    return false
  end
  
  def self.get_shared_list_access_rights(reading_list, user)
    access_rights = []
    if reading_list.user == user
      return OWNER
    end
    reading_list.reading_list_shares.each do |share|
      if share.group.users.include? user
        access_rights << share.access_rights
      end
    end
    return get_highest_access_right(access_rights)
  end
  
  def self.get_highest_access_right(access_rights)
    if access_rights.include? 'owner'
      return OWNER
    end
    if access_rights.include? 'readwrite'
      return READWRITE
    end
    if access_rights.include? 'readonly'
      return READONLY
    end
    return NONE
  end

  def self.get_unshared_groups(reading_list, owned_groups)
    result = []
    shared_groups = reading_list.groups.all
    owned_groups.each do |group|
      unless shared_groups.include? group
        result << group
      end
    end
    result
  end

end
