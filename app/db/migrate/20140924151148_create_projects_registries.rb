class CreateProjectsRegistries < ActiveRecord::Migration
  def change
    create_table :projects_registries do |t|
      t.references :project, index: true
      t.references :registry, index: true
    end
  end
end
