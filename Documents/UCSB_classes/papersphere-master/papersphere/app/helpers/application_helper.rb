module ApplicationHelper

  def is_active(controller_name)
    parsed_path = URI.parse(request.original_url).path
    return 'active' if controller_name == 'reading_lists' && parsed_path == '/'

    path = parsed_path.split('/')[1]
    if controller_name == path
      return 'active'
    elsif controller_name == "reading_lists" && path == "reading_list_papers"
      return 'active'
    else
      return ''
    end
  end
  
  def with_format(format, &block)
    old_formats = formats
    begin
      self.formats = [format]
      return block.call
    ensure
      self.formats = old_formats
    end
  end

end
