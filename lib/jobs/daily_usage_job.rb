class DailyUsageJob
  @queue = :test

  def self.perform()
    histories = History.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
    puts '=============================='
    testprint
    puts '-----------------------------'
  end
end
