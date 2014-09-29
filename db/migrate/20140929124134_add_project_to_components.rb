class AddProjectToComponents < ActiveRecord::Migration
  def change
    add_reference :components, :project, index: true
  end
end
