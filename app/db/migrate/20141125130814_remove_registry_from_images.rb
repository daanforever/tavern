class RemoveRegistryFromImages < ActiveRecord::Migration
  def change
    remove_reference :images, :registry, index: true
  end
end
