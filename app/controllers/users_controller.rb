# frozen_string_literal: true

require File.expand_path File.dirname(__FILE__) + '/concerns/get_user_name_and_accounts_service.rb'
class UsersController < ApplicationController
  def index
    render json: GetUserNameAndAccountsService.new(params).render_user_obj
  end
end
