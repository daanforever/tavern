class Docker::Shell

  attr_reader :connection, :instance #, :image, :container

  def initialize( host:, instance: nil )
    @instance   = instance
    Docker.logger = Rails.logger
    @connection = Docker::Connection.new(host, {})
  end

  def image
    instance_required
    @image ||= Docker::Shell::Images.new( connection: @connection, image: @instance.image )
  end

  def container
    instance_required
    @container ||= Docker::Shell::Container.new( connection: @connection, instance: @instance, image: @instance.image )
  end

  def info
    timeout( Settings.docker.timeout.to_i ){ Docker.info(@connection) }
  end
  
  protected
    def instance_required
      error_message if @instance.blank?
    end

    def error_message
      raise ArgumentError.new(
        'Instance is not set on Docker::Shell.new as required'
      )
    end
end


# class Docker::Connection
#   def request(*args, &block)
#       request = compile_request_params(*args, &block)
#       if Docker.logger
#         Docker.logger.debug(
#           [request[:method], request[:path], request[:query], request[:body]]
#         )
#       end

#       response = resource.request(request)
#       Docker.logger.debug(response.inspect.to_json) if Docker.logger
#       response.body

#     rescue Excon::Errors::BadRequest => ex
#       raise ClientError, ex.message
#     rescue Excon::Errors::Unauthorized => ex
#       raise UnauthorizedError, ex.message
#     rescue Excon::Errors::NotFound => ex
#       raise NotFoundError, ex.message
#     rescue Excon::Errors::InternalServerError => ex
#       raise ServerError, ex.response.data[:body]
#     rescue Excon::Errors::Timeout => ex
#       raise TimeoutError, ex.message
#     end
# end

