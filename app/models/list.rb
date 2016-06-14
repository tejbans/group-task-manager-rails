class List < ActiveRecord::Base
  has_many  :tasks, dependent: :destroy
  has_many  :users, through: :tasks
  validates :title, presence: true , uniqueness: true
  
 def tasks_attributes=(task_attributes)
  task_attributes.values.each do |task_attribute|
    if task_attribute[:title].present? 
      if !tasks.detect{|t| t.title.strip == task_attribute[:title].strip}
        task = tasks.build(task_attribute)
      end
    end
  end
end


end
