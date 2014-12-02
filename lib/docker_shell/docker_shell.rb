class DockerShell

  require 'docker_shell/container'
  require 'docker_shell/image'

  attr_reader :connection, :instance, :image, :container

  def initialize( instance: instance )
    @instance   = instance
    @connection = Docker::Connection.new(@instance.host.url, {})
    @container  = DockerShell::Container.new( connection: @connection, instance: @instance, image: @instance.image )
    @image      = DockerShell::Image.new( connection: @connection, image: @instance.image )
  end

end