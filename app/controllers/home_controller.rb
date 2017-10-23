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

  def index_charges
    @application_charges = ShopifyAPI::ApplicationCharge.all || []
  end

  def create_charges
    application_charge = ShopifyAPI::ApplicationCharge.new({:name => "Fee for validating shipping address", :price => 0.5, :status => 'accepted', :return_url => index_charges_url})
    application_charge.test = true
    #application_charge.return_url = index_charges_url
    if application_charge.save
      flash[:success] = "One-time charge was successfully created."
      #fullpage_redirect_to application_charge.confirmation_url
      #redirect_to index_charges_path
      if application_charge.activate
        flash[:success] = "One-time charge has been activated"
      end
      redirect_to index_charges_path
    else
      puts application_charge.errors.full_messages.first.to_s.capitalize
      flash[:danger] = application_charge.errors.full_messages.first.to_s.capitalize
      redirect_to index_charges_path
    end
  end

  def activate_charges
    application_charge = ShopifyAPI::ApplicationCharge.find(params[:id])
    if application_charge.activate
      flash[:success] = "One-time charge has been activated"
    end
    redirect_to index_charges_path
  end

  private
    def application_charge_params
      params.require(:application_charge).permit(
        :name,
        :price,
        :status
      )
    end

=begin
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
=end
end
