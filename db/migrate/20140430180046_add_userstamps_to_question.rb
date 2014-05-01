class AddUserstampsToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :creator_id, :integer
    add_column :questions, :updater_id, :integer
  end
end
