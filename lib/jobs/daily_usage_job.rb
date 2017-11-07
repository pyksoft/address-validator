class DailyUsageJob
  @queue = :test

  def self.perform()
    histories = History.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
    puts '=============================='
    HomeController.delay.daily_usage(price: histories.count * 0.03)
    puts '-----------------------------'
  end
end
