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
      container = nil
      timeout( Settings.docker.timeout.to_i ){
        container = Docker::Container.get({'Id' => @instance.container}, connection)
      }
      if container
        true
      else
        false
      end
    else
      false
    end
  end

  alias_method :exists?, :exist?

  def running?
    raise NotImplementedError.new
  end

  def create
    container = false
    timeout( Settings.docker.timeout.to_i ){
      container = Docker::Container.create({'Image' => @image.name}, connection)
    }
    if container
      Rails.logger.info("Container#create: container created with id:#{container.id}")
      container.id
    else
      Rails.logger.info("Container#create: failed to create container with image name: #{@image.name}")
      false
    end
  rescue Exception => e
    Rails.logger.info("Container#create: exception occurred: #{e.message}")
    Rails.logger.debug(e.backtrace.join("\n"))
    false
  end

  def start
    container = false
    timeout( Settings.docker.timeout.to_i ){
      container = Docker::Container.create({'Image' => @image.name}, connection)
    }
    if container
      Rails.logger.info("Container#start: found container with id:#{container.id}")
      timeout( Settings.docker.timeout.to_i ){
        Rails.logger.info("Container#start: trying to start container with id: #{container.id}")
        if container.start
          Rails.logger.info("Container#start: container with id: #{container.id} started!")
          @instance.container = container.id
        else
          Rails.logger.info("Container#start: container with id: #{container.id} failed to start")
        end
      }
    else
      false
    end
  rescue Exception => e # TODO: rescue only specified exceptions
    Rails.logger.debug("Container#start: instance: #{instance.id} #{e.class}: #{e.message}")
    Rails.logger.debug(e.backtrace.join("\n"))
    false
  end

end
