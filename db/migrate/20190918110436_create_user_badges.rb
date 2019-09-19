class CreateUserBadges < ActiveRecord::Migration[5.2]
  def change
    create_table :user_badges do |t|
      t.references :user, foreign_key: true
      t.references :badge, foreign_key: true

      t.timestamps
    end
  end

  def self.down
    drop_table :user_badges
  end
end
