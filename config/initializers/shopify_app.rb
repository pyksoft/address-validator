ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = "24d2a7cd0dabcb09bc6ec67264294ba8"
  config.secret = "a2e426bdd109156eabbb0bbda1cc41d8"
  config.scope = "read_orders, read_products"
  config.embedded_app = true
  config.after_authenticate_job = false
  config.session_repository = Shop
end
