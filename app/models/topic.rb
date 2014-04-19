class Topic < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :user
  has_many :comments, as: 'commentable'
  validates :title, :body, presence: true

  def destroy_by(user)
    self.destroy
  end
end
