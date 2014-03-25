class User < ActiveRecord::Base
  has_secure_password
  before_save{self.email=email.downcase}
  before_save{self.username=username.downcase}
  before_create{:create_remember_token}
  validates :name, presence: true,length: {maximum: 10}
  validates :username, uniqueness: {case_sensitive: false},presence: true,format: { with: /\A[a-z0-9][a-z0-9-]*\z/i }
  VALID_EMAIL=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,presence: true,
	           format: {with: VALID_EMAIL},
		   uniqueness: { case_sensitive: false }
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private
    
    def  create_remember_token
      self.remember_token=User.hash(User.new_remember_token)
    end
end
