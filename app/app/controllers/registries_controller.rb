class RegistriesController < ApplicationController
  before_action :set_registry, only: [ :show, :edit, :update, :destroy ]
  before_action :set_registries, only: [ :index, :refresh, :partial ]

  responders :flash
  respond_to :html, :json

  def index
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
    Registry.delay.refresh
    render partial: 'registries'
  end

  def toggle
    if params[:id]
      @registry = Registry.find(params[:id])
      @registry.toggle!(:disabled)
    else
      Registry.all.each{ |r| r.toggle!(:disabled) }
    end
    render json: {}
  end

  def partial
    render partial: 'registries'
  end

  private
    def set_registry
      @registry = Registry.find(params[:id])
    end

    def set_registries
      @registries = Registry.all
    end

    def registry_params
      params.require(:registry).permit(:name, :desc, :url, :disabled)
    end
end
