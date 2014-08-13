class AddStuffToUser < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_index :users, :firstname
    add_column :users, :lastname, :string
    add_index :users, :lastname
    add_column :users, :position, :string
  end
end
