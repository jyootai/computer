class Comment < ActiveRecord::Base
  include MarkdownHelper
  paginates_per 25

  has_many :notifications, as: 'subject', dependent: :delete_all
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  validates :commentable_type, inclusion: { in: %w(Topic) }
  validates :commentable, :user, presence: true
  validates :body, presence: true

  after_create :increment_counter_cache,:create_mention_notification,:create_comment_notification
  def increment_counter_cache
    if commentable.has_attribute? :comments_count
      commentable.class.update_counters commentable.id, comments_count: 1  
    end
  end

  def mention_users
    return @menton_users if defined?(@menton_users)
    doc = Nokogiri::HTML.fragment(markdown(body))
    usernames = doc.search('text()').map { |node|
      unless node.ancestors('a, pre, code').any?
	node.text.scan(/@([a-z0-9][a-z0-9-]*)/i).flatten
      end
    }.flatten.compact.uniq
    @menton_users = User.where(username: usernames)
  end

  def create_comment_notification
    users = commentable.user
    unless user==users
       Notification.create(user: users,
			  subject: self,
			  name: 'comment')
    end
  end

  def create_mention_notification
    users = mention_users-[user]
    users.each do |user|
      Notification.create(user: user,
			 subject: self,
			 name: 'mention')
    end
  end



    



end

