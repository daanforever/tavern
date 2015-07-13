class AddPrivatePortToInstances < ActiveRecord::Migration
  def change
    add_column :instances, :private_port, :integer
  end
end
