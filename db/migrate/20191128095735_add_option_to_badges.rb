class AddOptionToBadges < ActiveRecord::Migration[5.2]
  def change
    add_column :badges, :option, :integer
  end
end
