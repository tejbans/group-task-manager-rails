class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text  :description
      t.integer :user_id
      t.integer :list_id
      t.string  :status
      t.date    :due_date
      t.timestamps null: false
    end
  end
end
