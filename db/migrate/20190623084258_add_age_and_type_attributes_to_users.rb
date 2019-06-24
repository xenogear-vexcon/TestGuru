class AddAgeAndTypeAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :type, :string, null: false, default: 'User'
    add_column :users, :age, :integer, null: false, default: 20
    add_index :users, :type
  end
end
