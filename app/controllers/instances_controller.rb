class InstancesController < ApplicationController
  before_action :set_component
  before_action :set_environment
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

    if    @component
      @instance = Instance.new(component: @component)
    elsif @environment
      @instance = Instance.new(environment: @environment)
    else
      @instance = Instance.new
    end

    respond_with(@instance)
  end

  def edit
  end

  def create

    if    @component
      @instance = Instance.new(instance_params.merge(component: @component))
    elsif @environment
      @instance = Instance.new(instance_params.merge(environment: @environment))
    else
      @instance = Instance.new(instance_params)
    end

    if @instance.save
      respond_with(@component) if @component
      respond_with(@environment) if @environment
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
      @instance     = Instance.find(params[:id])
    end

    def set_instances
      @instances = if @component
        @component.instances
      elsif @environment
        @environment.instances
      else
        Instance.all
      end
    end

    def set_component
      @component    = Component.find(params[:component_id]) if params[:component_id]
    end

    def set_environment
      @environment  = Environment.find_by(id: params[:environment_id])
    end

    def instance_params
      params.require(:instance).permit(:name, :port, :image_id, :component_id, :host_id, :public_port, :private_port, :environment_id, :options)
    end
end
