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

  def create_recurring_application_charge
    unless ShopifyAPI::RecurringApplicationCharge.current
      recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(
              name: "Simpl address validation",
              price: 0.00,
              return_url: activate_charge_url,
              test: true,
              trial_days: 30,
              capped_amount: 100,
              terms: "$0.03 for validating an shipping address")

      if recurring_application_charge.save
        @tokens[:confirmation_url] = recurring_application_charge.confirmation_url
        redirect recurring_application_charge.confirmation_url
      end
    end
  end

  def activate_charge
    bulk_edit_url = root_path
    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(request.params['charge_id'])
    recurring_application_charge.status == "accepted" ? recurring_application_charge.activate : redirect(bulk_edit_url)
    #create_order_webhook
    redirect root_path
  end

  def create_usage_charge
    usage_charge = ShopifyAPI::UsageCharge.new(description: "$0.03 for validating an shipping address", price: 0.03)
    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.current
    usage_charge.prefix_options = {recurring_application_charge_id: recurring_application_charge.id}
    usage_charge.save
  end

end
