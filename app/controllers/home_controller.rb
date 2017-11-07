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
  end

  #validation histories
  def validation_history
    shop = ShopifyAPI::Shop.current    
    @histories = History.find_by shop: shop.domain
    #@histories = History.all
  end

  def create_recurring_application_charge
    #unless ShopifyAPI::RecurringApplicationCharge.current
      recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.new(
              name: "Simpl address validation",
              price: 0,
              return_url: activate_charge_url,
              test: true,
              trial_days: 30,
              capped_amount: 100,
              terms: "$0.03 for validating an shipping address")

      if recurring_application_charge.save
        #@tokens[:confirmation_url] = recurring_application_charge.confirmation_url
        flash[:success] = "One-time charge was successfully created"
        fullpage_redirect_to recurring_application_charge.confirmation_url
      else
        flash[:danger] = recurring_application_charge.errors.full_messages.first.to_s.capitalize
        redirect_to root_path
      end
    #end
  end

  def activate_charge
    bulk_edit_url = root_path
    recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.find(request.params['charge_id'])
    recurring_application_charge.status == "accepted" ? recurring_application_charge.activate : redirect(bulk_edit_url)
    redirect_to root_path
  end

  def self.create_usage_charge
    #if params(:price)
      price = params(:price)
      @usage_charge = ShopifyAPI::UsageCharge.new(description: "$0.03 for validating an shipping address", price: price)
      recurring_application_charge = ShopifyAPI::RecurringApplicationCharge.current
      @usage_charge.prefix_options = {recurring_application_charge_id: recurring_application_charge.id}
      @usage_charge.save
    #end
  end

  private
    def application_charge_params
      params.require(:application_charge).permit(
        :name,
        :price
      )
    end

end
