class TopicsCell < Cell::Rails

  def comments
    render
  end

  def topic_help_block(opts={})
    @full=opts[:full]||false
    render
  end

  def sidebar_statistics
    @users_count=User.unscoped.count
    @topics_count = Topic.unscoped.count
    @comments_count = Comment.unscoped.count
    render
  end

end
