# frozen_string_literal: true

require 'dotenv'
Dotenv.load('.env')
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :webmock
end
