class AddSubdomainToProject < ActiveRecord::Migration
  def change
    add_column :projects, :subdomain, :string
  end
end
