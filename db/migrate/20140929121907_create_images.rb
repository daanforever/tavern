class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.boolean :disabled
      t.references :registry, index: true
      t.references :project, index: true
      t.references :release, index: true
      t.references :component, index: true

      t.timestamps
    end
  end
end
