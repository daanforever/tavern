class DockerShell::Container

  attr_reader :connection, :instance, :image

  def initialize( connection: connection, instance: instance, image: image )
    @connection = connection
    @instance   = instance
    @image      = image
  end

  def exist?
    if @instance.container.present?
      raise NotImplementedError.new
    else
      false
    end
  end

  alias_method :exists?, :exist?

  def running?
    raise NotImplementedError.new
  end

end