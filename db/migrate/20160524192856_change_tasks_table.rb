class ChangeTasksTable < ActiveRecord::Migration
  def change
    change_column :tasks, :due_date, :datetime
  end
end
