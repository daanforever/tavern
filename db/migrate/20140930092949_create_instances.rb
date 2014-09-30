class CreateInstances < ActiveRecord::Migration
  def change
    create_table :instances do |t|
      t.string :name
      t.boolean :disabled
      t.integer :port
      t.string :container
      t.text :properties
      t.references :image, index: true
      t.references :component, index: true
      t.references :host, index: true

      t.timestamps
    end
  end
end
