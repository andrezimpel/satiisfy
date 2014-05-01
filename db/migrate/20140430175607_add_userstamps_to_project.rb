class AddUserstampsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :creator_id, :integer
    add_column :projects, :updater_id, :integer
  end
end
