# frozen_string_literal: true

require 'http'
require 'byebug'

class GetUserNameAndAccountsService
  def initialize(params)
    @user_id = params[:user_id].to_i
    raise 'Error: invalid input user_id params' if @user_id.zero?
  end

  def user_url
    "#{ENV['API_DOMAIN']}/users/#{@user_id}"
  end

  def accounts_url
    "#{ENV['API_DOMAIN']}/users/#{@user_id}/accounts"
  end

  def take_user_name
    json_response = JSON.parse HTTP.get(user_url).body
    json_response['attributes']['name']
  rescue StandardError
    raise 'Error: user is not exist or API get user is error'
  end

  def take_user_accounts
    @take_user_accounts = JSON.parse HTTP.get(accounts_url).body
    @take_user_accounts
  rescue StandardError
    raise 'Error: user is not exist or API get user is error'
  end

  def total_balance
    take_user_accounts.inject(0) { |sum, account| sum + account['attributes']['balance'] }
  end

  def render_user_obj
    { name: take_user_name, accounts: take_user_accounts, total_balance: total_balance }
  end
end
