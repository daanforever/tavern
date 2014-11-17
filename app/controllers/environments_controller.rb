class EnvironmentsController < ApplicationController
  before_action :set_project, only: [:index, :new, :create]
  before_action :set_environment, only: [:show, :edit, :update, :destroy]

  def index
    if @project
      @environments = @project.environments
    else
      @environments = Environment.all
    end
    respond_with(@environments)
  end

  def show
    respond_with(@environment)
  end

  def new
    @environment = Environment.new(project: @project)
    respond_with(@environment)
  end

  def edit
  end

  def create
    @environment = Environment.new(environment_params.merge(project: @project))
    @environment.save
    respond_with(@environment)
  end

  def update
    @environment.update(environment_params)
    respond_with(@environment)
  end

  def destroy
    @environment.destroy
    redirect_to projects_path
  end

  private
    def set_environment
      @environment = Environment.find(params[:id])
    end

    def set_project
      @project = Project.find(params[:project_id]) if params[:project_id]
    end

    def environment_params
      params.require(:environment).permit(:name, :release_id)
    end
end
