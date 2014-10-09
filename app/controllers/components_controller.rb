class ComponentsController < ApplicationController
  before_action :set_project, only: [:index]
  before_action :set_component, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if @project
      @components = @project.components
    else
      @components = Component.all
    end

    respond_with(@components)
  end

  def show
    respond_with(@component)
  end

  def new
    @component = Component.new
    respond_with(@component)
  end

  def edit
  end

  def create
    @component = Component.new(component_params)
    @component.save
    respond_with(@component)
  end

  def update
    @component.update(component_params)
    respond_with(@component)
  end

  def destroy
    @component.destroy
    respond_with(@component)
  end

  private
    def set_component
      @component = Component.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id]) if params[:project_id]
    end

    def component_params
      params.require(:component).permit(:name, :description, :disabled, instance_ids: [], instances: [ :image, :host, :port ])
    end
end
