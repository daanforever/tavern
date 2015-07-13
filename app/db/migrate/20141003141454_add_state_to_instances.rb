class AddStateToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :state, :integer
  end
end
