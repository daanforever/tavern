class CreateImagesRegistries < ActiveRecord::Migration
  def change
    create_table :images_registries do |t|
      t.references :registry, index: true
      t.references :image, index: true
    end
  end
end
