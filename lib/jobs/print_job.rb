class PrintJob
  @queue = :test

  def self.perform()
    puts "test12"
  end
end
