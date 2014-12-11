class SettingsController < ApplicationController
  before_action :set_setting, only: [:update]

  respond_to :html

  def index
    @settings = Settings.all
    respond_with(@settings)
  end

  def update
    @setting.update(settings_params)
    respond_with(@setting, location: settings_path)
  end

  private
    def set_setting
      @setting = Settings.find(params[:id])
    end

    def settings_params
      params.require(:settings).permit(:value)
    end
end
