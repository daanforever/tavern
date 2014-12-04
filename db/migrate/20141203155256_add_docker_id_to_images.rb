class AddDockerIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :docker_id, :string
  end
end
