class AddDefaultValuesToTables < ActiveRecord::Migration[5.2]
  def change
    change_column_default :tests, :level, from: true, to: false
  end

  def up
    change_column :answers, :correct, :boolean, default: false
  end

  def down
    change_column :answers, :correct, :boolean, default: nil
  end

end
