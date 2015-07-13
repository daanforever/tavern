class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :label
      t.boolean :visible
      t.boolean :disabled

      t.timestamps
    end
  end
end
