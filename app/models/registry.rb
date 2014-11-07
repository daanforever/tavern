# == Schema Information
#
# Table name: registries
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  url         :string(255)
#  disabled    :boolean
#  info        :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Registry < ActiveRecord::Base

  has_and_belongs_to_many :projects
  has_many                :images

  validates         :url, presence: true
  serialize         :info

  scope :enabled, -> { where(disabled: false) }

  def refresh
    return if self.url.blank?

    result = scan( search )

    self.update!( info: result )

    self

  end

  handle_asynchronously :refresh, queue: :registries, priority: 10

  def self.refresh
    Registry.all.each do |r|
      r.refresh
    end
  end


  def search
    Timeout::timeout(5) do
      @search ||= DockerRegistry::Registry.new(self.url).search
    end
  rescue => e
    e
  end

  def statistics
    OpenStruct.new({ projects:   projects_count,
                     releases:   releases_count,
                     components: components_count })
  end

  def scan(data)

    return nil if data.blank? or self.disabled? or not data.is_a?(Array)
    data.map do |r|

      project_name, component_name = r.name.split('/')

      r.tags.map do |tag|
        # ap ({ project: project_name, release: tag.name, component: component_name })
        project   = (Project.find_by(      name: project_name) or 
                     self.projects.create!(name: project_name))

        release   = (project.releases.find_by(name: tag.name) or 
                     project.releases.create!(name: tag.name))

        component = Component.find_or_create!(project: project, release: release, name: component_name)

        image     = (self.images.find_by(project: project, release: release, component: component) or 
                     self.images.create!(project: project, release: release, component: component, 
                                         name: "#{tag.repository.full_name}:#{tag.name}"))
        
        OpenStruct.new( { project: project_name, release: tag.name, component: component_name } )
      end
      
    end.flatten

  end

  protected
    def projects_count
      self.info.blank? ? 0 : self.info.map{ |r| r.project }.uniq.count
    end

    def releases_count
      self.info.blank? ? 0 : self.info.map{ |r| r.release }.uniq.count
    end

    def components_count
      self.info.blank? ? 0 : self.info.map{ |r| r.component }.uniq.count
    end

  # def project_cache( name: name )
  #   @project_cache ||= {}
  #   if @project_cache[name.to_sym].present?
  #     @project_cache[name.to_sym]
  #   else
  #     @project_cache[name.to_sym] = self.projects.find_by(name: name) or self.projects.create!(name: name)
  #   end
  # end

  # def release_cache( project: project, name: name )
  #   @release_cache ||= {}
  #   if @release_cache[name.to_sym].present?
  #     @release_cache[name.to_sym]
  #   else
  #     @release_cache[name.to_sym] = self.projects.find_by(name: name) or self.projects.create!(name: name)
  #   end
  # end

  # def project_cache( name: name )
  #   @project_cache ||= {}
  #   if @project_cache[name.to_sym].present?
  #     @project_cache[name.to_sym]
  #   else
  #     @project_cache[name.to_sym] = self.projects.find_by(name: name) or self.projects.create!(name: name)
  #   end
  # end

end
