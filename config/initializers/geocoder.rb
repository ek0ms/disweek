Geocoder.configure(
  lookup: :bing,
  api_key: ENV['BING_GEOCODE_ID'],
  timeout: 5,
  cache: Rails.cache
)
