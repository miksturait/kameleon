# require 'kameleon/ext/rspec/all'
# require 'kameleon/ext/active_record/shared_single_connection'


# require 'kameleon/ext/rspec/session_pool'

require 'kameleon/ext/rspec/dsl'
require 'kameleon/ext/rspec/headless'
require 'kameleon/ext/rspec/garbage_collector'

Dir["#{File.expand_path("../", __FILE__)}/support/**/*.rb"].each { |f| require f }

Capybara.configure do |c|
  c.default_driver= (ENV['CAPYBARA_DEFAULT_DRIVER']||:rack_test).to_sym
end
