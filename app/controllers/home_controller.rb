class HomeController < ShopifyApp::AuthenticatedController
  def index
    create_recurring_application_charge
    
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
              name: "Gift Basket Plan",
              price: 9.99,
              return_url: "https:\/\/#{APP_URL}\/activatecharge",
              test: true,
              trial_days: 7,
              capped_amount: 100,
              terms: "$0.99 for every order created")

      if recurring_application_charge.save
        @tokens[:confirmation_url] = recurring_application_charge.confirmation_url
        redirect recurring_application_charge.confirmation_url
      end
    end
  end

end
