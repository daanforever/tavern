# Small hack for debug

class Docker::Connection
  def request(*args, &block)
      request = compile_request_params(*args, &block)
      if Docker.logger
        Docker.logger.debug(
          [resource.inspect, request[:method], request[:path], request[:query], request[:body]]
        )
      end
      response = resource.request(request)

      if Docker.logger
        Docker.logger.debug(
          response.inspect
        )
      end

      response.body

    rescue Excon::Errors::BadRequest => ex
      raise ClientError, ex.message
    rescue Excon::Errors::Unauthorized => ex
      raise UnauthorizedError, ex.message
    rescue Excon::Errors::NotFound => ex
      raise NotFoundError, ex.message
    rescue Excon::Errors::InternalServerError => ex
      raise ServerError, ex.response.data[:body]
    rescue Excon::Errors::Timeout => ex
      raise TimeoutError, ex.message
    end
end

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

  def start
    Docker::Container.create({}, connection)
  rescue
    false
  end

end