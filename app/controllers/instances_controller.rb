class InstancesController < ApplicationController
  before_action :set_variables
  before_action :set_instance, only: [:show, :edit, :update, :destroy, :run, :stop]
  before_action :set_instances, only: [:index, :run, :stop]

  respond_to :json

  def index
    Rails.logger.debug("InstancesController: #{@instances.count}")
    respond_with(@instances)
  end

  def show
    respond_with(@instance)
  end

  def new
    @instance = Instance.new(environment: @environment)
    respond_with(@instance)
  end

  def edit
  end

  def create
    @instance = Instance.new(instance_params)
    if @instance.save
      respond_with(@environment, location: environment_instances_path(@environment))
    else
      flash.now[:alert] = @instance.errors
      respond_with(@environment, @instance)
    end
  end

  def update
    cleanup_properties
    @instance.update(instance_params)
    respond_with(@instance)
  end

  def destroy
    @instance.destroy
    respond_with(Project)
  end

  def run
    @instance.start
    render partial: 'instance_row', locals: { instance: @instance }
  end

  def stop
    @instance.stop
    render partial: 'instance_row', locals: { instance: @instance }
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

    def set_variables
      @component   = Component.find(params[:component_id]) if params[:component_id]
      @environment = Environment.find(params[:environment_id]) if params[:environment_id]
    end

    def instance_params
      params.require(:instance).permit(
        :name, :image_id, :component_id, :host_id, :environment_id,
        volumes: [:external, :internal], ports: [:public, :private]
      )
    end

    def cleanup_properties
      if instance_params['volumes']
        instance_params['volumes'].delete_if{|v| v['external'].blank? or v['internal'].blank?  }
      end
      if instance_params['ports']
        instance_params['ports'].delete_if{|v| v['public'].blank? or v['private'].blank?  }
      end
    end
end
