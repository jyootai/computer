class Category < ActiveRecord::Base
  has_many :topics, dependent: :nullify

  validates  :name, presence: true
end
