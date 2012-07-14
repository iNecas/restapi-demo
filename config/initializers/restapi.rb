Restapi.configure do |config|
  config.app_name = "TwitterScheduler"
  config.app_info = "Write now, tweet tomorrow"
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/*.rb"
end
