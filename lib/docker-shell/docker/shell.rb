class Docker::Shell

  require 'docker/shell/images'
  require 'docker/shell/container'

  attr_reader :connection, :instance, :image, :container

  def initialize( instance: instance )
    @instance   = instance
    Docker.logger = Rails.logger
    @connection = Docker::Connection.new(@instance.host.url, {})
    @container  = Docker::Shell::Container.new( connection: @connection, instance: @instance, image: @instance.image )
    @image      = Docker::Shell::Images.new( connection: @connection, image: @instance.image )
  end
end

class Docker::Connection
  def request(*args, &block)
      request = compile_request_params(*args, &block)
      if Docker.logger
        Docker.logger.debug(
          [request[:method], request[:path], request[:query], request[:body]]
        )
      end

      response = resource.request(request)
      Docker.logger.debug(response.inspect.to_json) if Docker.logger
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

