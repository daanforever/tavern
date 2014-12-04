class DockerShell::Image
  attr_reader :connection, :image

  def initialize( connection: connection, image: image )
    @connection = connection
    @image      = image
  end

  def exist?
    false
  end

  alias_method :exists?, :exist?

  def pull
    false
  end

end