module ApplicationHelper
  def return_to_path(path)
    case path
    when '/' , /^\/login/, /^\/signup/
      nil
    else
      path
    end
  end
  
  def timeago(time, options={})
     options[:class]
     options[:class] = options[:class].blank? ? "timeago" : [options[:class],"timeago"].join(" ")
    content_tag(:abbr, "", options.merge(:title => time.iso8601)) if time
  end
  
  def owner?(topic)
    return false if topic.blank? or current_user.blank?
    topic.user_id==current_user.id
  end
end
