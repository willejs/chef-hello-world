# Added by ChefSpec
require 'chefspec'

# use ChefSpec's Berkshelf extension
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.mock_with :rspec do |mocks|
    mocks.syntax = :should
  end
  # Specify the Chef log_level (default: :warn)
  config.log_level = :error

  # Specify the operating platform to mock Ohai data from
  config.platform = 'ubuntu'

  # Specify the operating version to mock Ohai data from
  config.version = '14.04'
end
