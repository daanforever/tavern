class Registry < ActiveRecord::Base

  has_and_belongs_to_many :projects

  validates :url, presence: true

  def refresh
    self.projects = registry_scan.map do |item|
      cache( item.project ) or self.projects.create!(name: item.project)
    end
    statistics( registry_scan )
  end

  def registry_scan
    registry_search.map do |r|
      project, component = r.name.split('/')
      OpenStruct.new( { project: project, component: component, releases: r.tags.map{ |t| t.name } } )
    end
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

  def cache( name )
    @cache ||= {}
    @cache[name.to_sym].present? ? @cache[name.to_sym] : @cache[name.to_sym] = self.projects.find_by(name: name)
  end


end