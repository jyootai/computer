class User < ActiveRecord::Base
  include Gravtastic
  gravtastic secure: true, default: 'wavatar', rating: 'G', size: 48
  mount_uploader :avatar, AvatarUploader
  has_many :topics, dependent: :destroy 
  has_many :comments, dependent: :destroy
  has_many :attachments, dependent: :delete_all
  has_secure_password
  before_save{self.email=email.downcase}
  before_save{self.username=username.downcase}
  validates :name, presence: true,length: {maximum: 10}
  validates :username, uniqueness: {case_sensitive: false},presence: true,format: { with: /\A[a-z0-9][a-z0-9-]*\z/i }
  VALID_EMAIL=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence: true,
	           format: {with: VALID_EMAIL},
		   uniqueness: { case_sensitive: false }

  def remember_token 
    [id, Digest::SHA512.hexdigest(password_digest)].join('$')
  end

  def self.find_by_remember_token(token)
    user = find_by_id(token.split('$').first)
    (user && Rack::Utils.secure_compare(user.remember_token, token)) ? user : nil
  end

end
