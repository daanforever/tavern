class RenamePortInInstances < ActiveRecord::Migration
  def change
    rename_column :instances, :port, :public_port
  end
end
