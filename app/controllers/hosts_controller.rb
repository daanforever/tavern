class HostsController < ApplicationController
  before_action :set_host, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @hosts = Host.all
    respond_with(@hosts)
  end

  def show
    respond_with(@host)
  end

  def new
    @host = Host.new
    respond_with(@host)
  end

  def edit
  end

  def create
    @host = Host.new(host_params)
    @host.save
    respond_with(@host)
  end

  def update
    @host.update(host_params)
    respond_with(@host)
  end

  def destroy
    @host.destroy
    respond_with(@host)
  end

  private
    def set_host
      @host = Host.find(params[:id])
    end

    def host_params
      params.require(:host).permit(:url, :name, :description, :disabled)
    end
end
