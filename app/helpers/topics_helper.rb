module TopicsHelper
  
  def topic_last_path(topic)
    topic_path(topic,anchor: (topic.comments_count if topic.comments_count>0))
  end


end
