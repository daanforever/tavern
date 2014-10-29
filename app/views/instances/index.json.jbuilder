json.array!(@instances) do |instance|
  # json.extract! instance, :id, :name, :public_port, :private_port, :image_id, :component_id, :host_id
  json.environment          instance.environment.name
  json.host                 instance.host.name
  json.release              instance.image.release.name
  json.extract!             instance, :public_port, :private_port, :state
  json.instance_path        instance_path(instance)
  json.edit_instance_path   edit_instance_path(instance)
  json.stop_instance_path   stop_instance_path(instance)
  json.run_instance_path    run_instance_path(instance)
end
