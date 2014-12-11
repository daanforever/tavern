# Small hack for debug

class Docker::Shell::Container

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

  def start
    timeout( Settings.docker.timeout.to_i ){
      Docker::Container.create({'Image' => @image.name}, connection)
    }
  rescue Exception => e
    Rails.logger.debug("Container#start: instance: #{instance.id} #{e.class}: #{e.message}")
    false
  end

end
