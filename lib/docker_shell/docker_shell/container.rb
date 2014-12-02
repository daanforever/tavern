class DockerShell::Container

  attr_reader :connection, :instance, :image

  def initialize( connection: connection, instance: instance, image: image )
    @connection = connection
    @instance   = instance
    @image      = image
  end

  def exist?
    @instance.container.present?
  end

  def running?
    raise NotImplementedError.new
  end

end