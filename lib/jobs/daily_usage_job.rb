class DailyUsageJob
  @queue = :test

  def self.perform()
    histories = History.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)
    #HomeController.daily_usage(price: histories.count * 0.03)
    #daily_usage = DailyUsage.new(price: 10)
    #daily_usage.save
    @usage_charge = ShopifyAPI::UsageCharge.new(description: "$0.03 for validating an shipping address", price: params[:price])
    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.current
    @usage_charge.prefix_options = {recurring_application_charge_id: recurring_application_charge.id}
    @usage_charge.save
  end
end
