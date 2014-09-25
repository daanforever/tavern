class AddProjectToReleases < ActiveRecord::Migration
  def change
    add_reference :releases, :project, index: true
  end
end
