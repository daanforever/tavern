class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :name
      t.string :description
      t.string :label

      t.timestamps
    end
  end
end
