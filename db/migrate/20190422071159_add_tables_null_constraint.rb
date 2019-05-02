class AddTablesNullConstraint < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:tests, :title, false)
    change_column_null(:questions, :body, false)
    change_column_null(:answers, :body, false)
    change_column_null(:answers, :correct, false)
    change_column_null(:users, :name, false)
    change_column_null(:users, :age, false)
    change_column_null(:users, :email, false)
    change_column_null(:users, :password, false)
    change_column_null(:categories, :title, false)
  end
end
