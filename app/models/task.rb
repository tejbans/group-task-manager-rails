class Task < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :list
  validates :title, presence: true , uniqueness: { case_sensitive: false }
  validates :due_date, presence: true
  validate :due_date_cannot_be_in_the_past
  
  enum status: [:in_progress, :completed]

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end

  def user_info
    if self.user
       user.email
     end
  end

end
