class AddFastLoginIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :fast_login_id, :string, unique: true
    add_index :users, :fast_login_id
  end
end
