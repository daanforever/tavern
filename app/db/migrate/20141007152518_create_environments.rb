class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.string :name
      t.references :project, index: true
      t.references :release, index: true

      t.timestamps
    end
  end
end
