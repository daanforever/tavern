# json.extract! @registry, :id, :name, :url, :state, :created_at, :updated_at
json.images do 
  json.array!(@registry.images) do |image|
    json.name image.name
  end
end
