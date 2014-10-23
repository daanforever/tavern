json.array!(@instances) do |instance|
  json.extract! instance, :id, :name, :public_port, :private_port, :image_id, :component_id, :host_id
  json.url instance_url(instance, format: :json)
end
