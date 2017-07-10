require 'config'
require 'dotenv/load'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  Config.load_and_set_settings(Config.setting_files('./config', 'test'))
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.color = true
end
