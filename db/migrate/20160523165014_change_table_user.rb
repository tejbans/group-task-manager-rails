class ChangeTableUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename  :name, :email
      t.string  :password_digest
    end
  end
end
