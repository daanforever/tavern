# == Schema Information
#
# Table name: registries
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  desc       :string(255)
#  url        :string(255)
#  disabled   :boolean
#  created_at :datetime
#  updated_at :datetime
#

class Registry < ActiveRecord::Base

  has_and_belongs_to_many :projects

  validates :url, presence: true

  def refresh
    self.projects = registry_scan.map do |item|
      project_cache( item.project ) or self.projects.create!(name: item.project)
    end
    statistics( registry_scan )
  end

  def registry_scan
    info = Hash.new( {} )
    registry_search.each do |r|
      project, component = r.name.split('/')
      r.tags.map do |tag|
        # ap [ project, tag.name, component ]
        info[project][tag.name].is_a?(Array) or info[project][tag.name] = []
        info[project][tag.name] << component
        p info.inspect
      end
    end
    info
  end

  def registry_search
    @registry_scan ||= DockerRegistry::Registry.new(self.url).search
  rescue => e
    e
  end

  protected
  def statistics( info )
    { projects:   info.map{ |r| r.project }.uniq.count,
      components: info.map{ |r| r.component }.uniq.count,
      releases:   info.map{ |r| r.releases }.flatten.uniq.count }
  end

  def project_cache( name )
    @project_cache ||= {}
    @project_cache[name.to_sym].present? ? @project_cache[name.to_sym] : @project_cache[name.to_sym] = self.projects.find_by(name: name)
  end


end
