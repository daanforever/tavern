class Background
  include Delayed::RecurringJob
  queue 'every1min'
  run_every 1.minute
  def perform
    logger.info('Background job start')
    Registry.delay(queue: :registries).refresh
    logger.info('Background job end')
  end
end
