module CommentsHelper

  def comment_replace_path(comment)
    case comment.commentable
    when Topic
      topic_last_path(@comment.commentable)
    end
  end

end
