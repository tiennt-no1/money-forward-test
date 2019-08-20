# frozen_string_literal: true

require_relative '../app/controllers/concerns/get_user_name_and_accounts_service.rb'
require_relative './spec_helper.rb'

RSpec.describe GetUserNameAndAccountsService do
  it 'invalid user_id params' do
    error_message = 'Error: invalid input user_id params'
    expect { GetUserNameAndAccountsService.new(user_id: 0) }.to raise_error(error_message)
    expect { GetUserNameAndAccountsService.new(user_id: nil) }.to raise_error(error_message)
    expect { GetUserNameAndAccountsService.new(user_id: 'abc') }.to raise_error(error_message)
  end

  it 'work normal' do
    VCR.use_cassette('user1') do
      service = GetUserNameAndAccountsService.new(user_id: 1)
      expect(service.take_user_name).to_not be_nil
      expect(service.take_user_accounts).to be_a(Array)
      expect(service.take_user_accounts).to_not be_nil
      expect(service.total_balance).to_not be_nil
      expect(service.total_balance).to be >= 0

      expect(service.render_user_obj).to_not be_nil
      expect(service.render_user_obj).to be_a(Hash)
    end
  end

  it 'user not exist or API get user is error' do
    VCR.use_cassette('user1000') do
      error_message = 'Error: user is not exist or API get user is error'
      service = GetUserNameAndAccountsService.new(user_id: 1000)
      expect { service.take_user_name }.to raise_error(error_message)
      expect { service.take_user_accounts }.to raise_error(error_message)
      expect { service.total_balance }.to raise_error(error_message)
      expect { service.render_user_obj }.to raise_error(error_message)
    end
  end
end
