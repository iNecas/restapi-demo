require 'twitterscheduler_client/base'

resource_files = Dir[File.expand_path('../twitterscheduler_client/resources/*.rb', __FILE__)]
resource_files.each { |f| require f }

module TwitterschedulerClient
  def self.client_config
    @client_config ||= {:base_url => "http://localhost:3000"}
  end
end
