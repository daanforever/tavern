json.array!(@environments) do |environment|
  json.extract! environment, :id, :name, :release_id
  json.url environment_url(environment, format: :json)
end
