class Comment < ActiveRecord::Base
  include MarkdownHelper

  paginates_per 25
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  validates :commentable_type, inclusion: { in: %w(Topic) }
  validates :commentable, :user, presence: true
  validates :body, presence: true

  after_create :increment_counter
  def increment_counter
    if commentable.has_attribute? :comments_count
      commentable.class.update_counters commentable.id, comments_count: 1  
    end
  end
end
