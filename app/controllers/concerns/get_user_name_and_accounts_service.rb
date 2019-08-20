# frozen_string_literal: true

require 'http'

class GetUserNameAndAccountsService
  def initialize(params)
    @user_id = params[:user_id]
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
  end

  def take_user_accounts
    json_response = JSON.parse HTTP.get(accounts_url).body
    json_response
  end

  def render_user_obj
    { name: take_user_name, accounts: take_user_accounts }
  end
end
