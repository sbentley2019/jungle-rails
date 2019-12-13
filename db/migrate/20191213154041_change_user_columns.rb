class ChangeUserColumns < ActiveRecord::Migration
  def change
    add_column :users, :lastname, :string
    rename_column :users, :name, :firstname
  end
end
