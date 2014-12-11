Rails.application.config.after_initialize do
  begin
    Background.schedule!
  rescue
    Rails.logger.warn('Background job not started')
  end
end
