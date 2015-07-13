class SettingsController < ApplicationController
  before_action :set_settings

  respond_to :html

  def index
    respond_with(@settings)
  end

  def update
    # @setting.update(settings_params)
    settings_params.each{|key, value| Settings.send(key.to_s + "=", value) }
    respond_with(@setting, location: edit_settings_path)
  end

  private
    def set_settings
      @settings = Settings.all
    end

    def settings_params
      # params.require(:settings).permit(:key, :value)
      params.require(:settings)
    end
end
