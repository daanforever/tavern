class RemovePublicPortPrivatePortFromInstances < ActiveRecord::Migration
  def change
    remove_column :instances, :public_port, :integer
    remove_column :instances, :private_port, :integer
  end
end
