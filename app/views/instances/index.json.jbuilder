json.array!(@instances.includes(:environment, :host, image: [:release])) do |instance|
  # json.extract! instance, :id, :name, :public_port, :private_port, :image_id, :component_id, :host_id
  json.id                   instance.id
  json.project              instance.component.project.name
  json.component            instance.component.name
  json.environment          instance.environment.name
  json.host                 instance.host.name.split(/\./).first
  json.release              instance.image.release.name
  json.state                instance.state
  json.instance_path        instance_path(instance)
  json.edit_instance_path   edit_instance_path(instance)
  json.stop_instance_path   stop_instance_path(instance)
  json.run_instance_path    run_instance_path(instance)
end
