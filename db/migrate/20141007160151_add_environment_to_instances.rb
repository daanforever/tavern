class AddEnvironmentToInstances < ActiveRecord::Migration
  def change
    add_reference :instances, :environment, index: true
  end
end
