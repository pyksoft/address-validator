class DailyUsageJob
  @queue = :test

  def self.perform()
    histories = History.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
    histories.count
    puts "#{Time.now.midnight - 1.day} ... #{Time.now.midnight} : #{histories.count}"
    #HomeController.create_usage_charge(price: histories.count * 0.03)
    HomeController.create_usage_charge(price: 10 * 0.03)
  end
end
