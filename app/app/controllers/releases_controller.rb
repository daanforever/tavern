class ReleasesController < ApplicationController
  before_action :set_project
  before_action :set_release, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @releases = @project ? @project.releases : Release.all
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
    respond_with(@project, location: project_releases_path(@project))
  end

  private
    def set_release
      @release = Release.find(params[:id])
    end

    def set_project
      @project = Project.find_by(id: params[:project_id]) if params[:project_id]
    end

    def release_params
      params.require(:release).permit(:name, :description, :label)
    end
end
