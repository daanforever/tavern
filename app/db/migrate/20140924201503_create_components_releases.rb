class CreateComponentsReleases < ActiveRecord::Migration
  def change
    create_table :components_releases do |t|
      t.references :component, index: true
      t.references :release, index: true
    end
  end
end
