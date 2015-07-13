class CreateRegistries < ActiveRecord::Migration
  def change
    create_table :registries do |t|
      t.string :name
      t.string :description
      t.string :url
      t.boolean :disabled
      t.text :info

      t.timestamps
    end
  end
end
