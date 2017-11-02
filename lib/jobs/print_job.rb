class PrintJob
  @queue = :test

  def self.perform()
    puts "test"
  end
end 
