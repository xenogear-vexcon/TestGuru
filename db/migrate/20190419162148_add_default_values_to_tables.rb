class AddDefaultValuesToTables < ActiveRecord::Migration[5.2]
  # def change
  # end
  def up
    change_column :tests, :level, :integer, default: true
    change_column :answers, :correct, :integer, default: true
  end
  def down
    change_column :tests, :level, :integer, default: nil
    change_column :answers, :correct, :integer, default: nil
  end
end
