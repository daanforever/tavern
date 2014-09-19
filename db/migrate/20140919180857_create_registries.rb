class CreateRegistries < ActiveRecord::Migration
  def change
    create_table :registries do |t|
      t.string :name
      t.string :desc
      t.string :url
      t.boolean :disabled

      t.timestamps
    end
  end
end
