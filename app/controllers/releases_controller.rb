class ReleasesController < ApplicationController
  before_action :set_project, only: [:index]
  before_action :set_release, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @releases = @project ? @project.releases.ordered : Release.all
    respond_with(@releases)
  end

  def show
    respond_with(@release)
  end

  def new
    @release = Release.new
    respond_with(@release)
  end

  def edit
  end

  def create
    @release = Release.new(release_params)
    @release.save
    respond_with(@release)
  end

  def update
    @release.update(release_params)
    respond_with(@release)
  end

  def destroy
    @release.destroy
    respond_with(@release)
  end

  private
    def set_release
      @release = Release.find(params[:id])
    end

    def set_project
      @project = Project.find_by(id: params[:project_id])
    end

    def release_params
      params.require(:release).permit(:name, :description, :label)
    end
end
