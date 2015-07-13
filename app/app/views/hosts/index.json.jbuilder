json.array!(@hosts) do |host|
  json.extract! host, :id, :url, :name, :description, :disabled
  # json.url host_url(host, format: :json)
end
