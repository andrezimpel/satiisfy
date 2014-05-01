class AddUserstampsToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :creator_id, :integer
    add_column :accounts, :updater_id, :integer
  end
end
