class RegistriesController < ApplicationController
  before_action :set_registry, only: [:show, :edit, :update, :destroy]

  responders :location, :flash
  respond_to :html

  def index
    @registries = Registry.all
    respond_with(@registries)
  end

  def show
    respond_with(@registry)
  end

  def new
    @registry = Registry.new
    respond_with(@registry)
  end

  def edit
  end

  def create
    @registry = Registry.new(registry_params)
    @registry.save
    respond_with @registry, location: -> { registries_path }
  end

  def update
    @registry.update(registry_params)
    respond_with @registry, location: -> { registries_path }
  end

  def destroy
    @registry.destroy
    respond_with(@registry)
  end

  def refresh
    sleep 2
    render status: 200, json: {}
  end

  def disable
    sleep 2
    render status: 200, json: {}
  end

  private
    def set_registry
      @registry = Registry.find(params[:id])
    end

    def registry_params
      params.require(:registry).permit(:name, :desc, :url, :disabled)
    end
end
