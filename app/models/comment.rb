class Comment < ActiveRecord::Base
  include MarkdownHelper
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  validates :commentable_type, inclusion: { in: %w(Topic) }
  validates :commentable, :user, presence: true

  validates :body, presence: true
end
