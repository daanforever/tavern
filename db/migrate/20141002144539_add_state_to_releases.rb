class AddStateToReleases < ActiveRecord::Migration
  def change
    add_column :releases, :state, :integer
  end
end
