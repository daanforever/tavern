# json.extract! @registry, :id, :name, :url, :state, :created_at, :updated_at
json.images do 
  json.array!(@registry.images.includes(:project, :component, :release)) do |image|
    json.name       image.name
    json.project    image.project.name
    json.component  image.component.name
    json.release    image.release.name
    json.docker_id  image.docker_id
  end
end
