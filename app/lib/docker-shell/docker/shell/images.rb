class Docker::Shell::Images
  attr_reader :connection, :image

  def initialize( connection:, image: )
    @connection = connection
    @image      = image
  end

  def exist?
    # TODO: set timeout for external (Docker) call
    timeout( Settings.docker.timeout.to_i ){
      Docker::Image.exist?(image.docker_id, {}, @connection)
    }
  rescue
    false
  end

  alias_method :exists?, :exist?

  def pull
    # TODO: change to pull from best registry
    # Docker::Image.create({registry: image.registries.first.name, 
    #                       repo: image.project.name, 
    #                       fromImage: image.component.name, 
    #                       tag: image.release.name}, nil, @connection)
    timeout( Settings.docker.timeout.to_i ){
      Docker::Image.create({ fromImage: "#{image.name}" }, nil, @connection)
    }
  rescue
    false
  end

  def info
    Docker::Image.get(image.docker_id, {}, @connection).info if self.exist?
  end
end
