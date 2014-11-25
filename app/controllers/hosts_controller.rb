class HostsController < ApplicationController
  before_action :set_environment
  before_action :set_host, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    if @environment
      @hosts = @environment.hosts
    else
      @hosts = Host.all
    end
    respond_with(@hosts)
  end

  def show
    respond_with(@host)
  end

  def new
    @host = Host.new(environment: @environment)
    respond_with(@host)
  end

  def edit
  end

  def create
    @host = Host.new(host_params.merge(environment: @environment))
    unless @host.save
      flash.now[:alert] = @host.errors
    end
    respond_with(@environment)
  end

  def update
    flash[:notice] = "Updated"
    @host.update(host_params)
    respond_with(@host)
  end

  def destroy
    @host.destroy
    respond_with(Environment)
  end

  def toggle
    if defined? params[:id]
      @host = Host.find(params[:id])
      @host.toggle!(:disabled)
    else
      Host.all.each{ |r| r.toggle!(:disabled) }
    end
    render json: {}
  end

  private
    def set_host
      @host = Host.find(params[:id])
    end

    def set_environment
      @environment = Environment.find( params[:environment_id] ) if params[:environment_id]
    end

    def host_params
      params.require(:host).permit(:url, :name, :description, :disabled, :environment_id)
    end
end
