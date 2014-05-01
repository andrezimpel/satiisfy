class AddUserstampsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :creator_id, :integer
    add_column :profiles, :updater_id, :integer
  end
end
