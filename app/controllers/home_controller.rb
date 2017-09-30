class HomeController < ShopifyApp::AuthenticatedController
  def index
    @shop = ShopifyAPI::Shop.current
    @setting = Setting.find_by store_domain: @shop.domain
    if @setting.nil?
      @setting = Setting.new
      @setting.store_domain = @shop.domain
      @setting.save
    end
    redirect_to edit_setting_path(@setting)
  end
end
