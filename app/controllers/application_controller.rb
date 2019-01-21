# frozen_string_literal: true

# Setting up global variables and method to be used be all controllers
class ApplicationController < ActionController::API
  # The server passes the request headers to AuthorizeApiRequest every time
  # the user makes a request
  before_action :authenticate_request

  attr_reader :current_user
  # helper_method :current_user

  private

  # To persist the user and make current_user be available to all controllers
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
