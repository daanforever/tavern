Rails.application.config.after_initialize do
  begin
    Settings.docker.timeout? || Settings.docker.timeout = 10
  rescue
    Rails.logger.warn('Settings not defined')
  end
end