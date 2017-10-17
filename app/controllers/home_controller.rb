class HomeController < ShopifyApp::AuthenticatedController
  def index
    #create_recurring_application_charge

    @shop = ShopifyAPI::Shop.current
    @setting = Setting.find_by store_domain: @shop.domain
    if @setting.nil?
      @setting = Setting.new
      @setting.store_domain = @shop.domain
      @setting.save
    end
    #redirect_to edit_setting_path(@setting)
  end
=begin
  def create_recurring_application_charge
    unless ShopifyAPI::RecurringApplicationCharge.current
      recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(
              name: "Gift Basket Plan",
              price: 0.01,
              return_url: activate_charge_url,
              test: true,
              trial_days: 30,
              capped_amount: 100,
              terms: "$0.01 for every order created")

      if recurring_application_charge.save
        @tokens[:confirmation_url] = recurring_application_charge.confirmation_url
        redirect recurring_application_charge.confirmation_url
      end
    end
  end

  def activate_charge
    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(request.params['charge_id'])
    recurring_application_charge.status == "accepted" ? recurring_application_charge.activate : redirect(bulk_edit_url)
    create_order_webhook
    redirect root_path
  end

  def create_usage_charge
    usage_charge = ShopifyAPI::UsageCharge.new(description: "$0.99 for every order created", price: 0.01)
    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.current
    usage_charge.prefix_options = {recurring_application_charge_id: recurring_application_charge.id}
    usage_charge.save
  end
=end
end
