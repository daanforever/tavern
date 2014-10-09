class InstancesController < ApplicationController
  before_action :set_component
  before_action :set_instance, only: [:show, :edit, :update, :destroy, :run, :stop]
  before_action :set_instances, only: [:index, :run, :stop]

  respond_to :html

  def index
    respond_with(@instances)
  end

  def show
    respond_with(@instance)
  end

  def new
    @instance           = Instance.new(component: @component)
    respond_with(@instance)
  end

  def edit
  end

  def create
    @instance           = Instance.new(instance_params.merge(component: @component))
    if @instance.save
      respond_with(@component)
    else
      flash.now[:alert] = @instance.errors
      respond_with(@instance)
    end
  end

  def update
    @instance.update(instance_params)
    respond_with(@instance)
  end

  def destroy
    @instance.destroy
    respond_with(@component)
  end

  def run
    @instance.run!
    render partial: 'instances_table'
  end

  def stop
    @instance.stop!
    render partial: 'instances_table'
  end

  private
    def set_instance
      @instance   = Instance.find(params[:id])
    end

    def set_instances
      @instances = @component ? @component.instances : Instance.all
    end

    def set_component
      @component  = Component.find(params[:component_id]) if params[:component_id]
    end

    def instance_params
      params.require(:instance).permit(:name, :port, :image_id, :component_id, :host_id, :public_port, :private_port, :environment_id)
    end
end
