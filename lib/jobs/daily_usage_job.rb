class DailyUsageJob
  @queue = :test

  def self.perform()
    histories = History.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
    #HomeController.daily_usage(price: histories.count * 0.03)
    daily_usage = DailyUsage.new(price: 10)
    daily_usage.save
  end
end
