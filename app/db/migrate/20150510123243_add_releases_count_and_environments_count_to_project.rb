class AddReleasesCountAndEnvironmentsCountToProject < ActiveRecord::Migration
  def change
    add_column :projects, :releases_count, :integer, null: false, default: 0
    add_column :projects, :environments_count, :integer, null: false, default: 0

    reversible do |dir|
      # Post.find_each { |post| Post.reset_counters(post.id, :comments) }
      dir.up { 
        Project.find_each do |p| 
          Project.reset_counters(p.id, :releases, :environments)
        end
      }
    end
  end
end
