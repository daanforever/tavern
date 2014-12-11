class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @settings = Settings.all
    respond_with(@settings)
  end

  def create
    @setting = Settings.new(settings_params)
    @setting.save
    respond_with(@setting)
  end

  def update
    @setting.update(settings_params)
    respond_with(@setting)
  end

  def destroy
    @setting.destroy
    respond_with(@setting)
  end

  private
    def set_setting
      @setting = Settings.find(params[:id])
    end

    def setting_params
      params[:setting]
    end
end
