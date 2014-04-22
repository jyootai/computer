class Topic < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :user
  has_many :comments, as: 'commentable'
  validates :title, :body, presence: true

  def destroy_by(user)
    self.destroy
  end

  def more_like_this(num=5)
    Topic.search(
      query: {
	more_like_this: {
	fields: ['title', 'body'],
        like_text: title + '\n' + body
	}
      },
      filter: {
	and: [
	  { term: { trashed: false } },
	  { not: { term: { id: id } } }
	]
      }
    ).limit(num).records.to_a rescue []
  end
end
