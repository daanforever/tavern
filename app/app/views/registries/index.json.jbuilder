json.array!(@registries) do |registry|
  json.extract! registry, :id, :name, :desc, :url, :disabled
  json.url registry_url(registry, format: :json)
end
