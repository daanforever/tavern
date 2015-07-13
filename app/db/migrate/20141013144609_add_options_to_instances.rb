class AddOptionsToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :options, :text
  end
end
