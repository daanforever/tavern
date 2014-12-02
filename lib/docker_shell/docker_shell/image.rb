class DockerShell::Image
  attr_reader :connection, :image

  def initialize( connection: connection, image: image )
    @connection = connection
    @image      = image
  end

  def exists?
    false
  end

end