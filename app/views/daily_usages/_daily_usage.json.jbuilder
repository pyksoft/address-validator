json.extract! daily_usage, :id, :price, :created_at, :updated_at
json.url daily_usage_url(daily_usage, format: :json)
