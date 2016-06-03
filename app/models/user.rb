class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  
  validates :email, presence: true, length: { minimum: 8 },uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  has_secure_password
  has_many  :tasks
  has_many  :lists, through: :tasks

  def self.find_or_create_by_omniauth(auth_hash)
    self.where(:email => auth_hash["info"]["email"]).first_or_create do |user|
      user.password = SecureRandom.hex
    end
  end

  def completed_tasks
    tasks.select {|task| task.status == "completed"}
  end

  def overdue_tasks
    tasks.select {|task| task.status == 'in_progress' && task.due_date <  Time.now }
  end
  
end
