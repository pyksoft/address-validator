class DailyUsageJob
  @queue = :test

  def self.perform()
    histories = History.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
    HomeController.daily_usage(price: histories.count * 0.03)
  end
end
