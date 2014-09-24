class CreateProjectsReleases < ActiveRecord::Migration
  def change
    create_table :projects_releases do |t|
      t.references :project, index: true
      t.references :release, index: true
    end
  end
end
