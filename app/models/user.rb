class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  
  validates :email, presence: true, length: { minimum: 8 },uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  has_many  :tasks
  has_many  :lists, through: :tasks

  
end
