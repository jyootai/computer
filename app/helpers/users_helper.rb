module UsersHelper
  def render_user_join_time(user)
     user.created_at.to_date
  end
  
  def render_user_personal_bio(user)
    bio = user.bio[/^https?:\/\//] ? user.bio : "http://" + user.bio
    link_to(bio, bio, :target => "_blank", :class => "url", :rel => "nofollow")
  end

  def user_link(user)
    user_path(user.username)
  end
    
end
