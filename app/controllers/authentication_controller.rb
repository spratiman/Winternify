# frozen_string_literal: true

# Identifying user log-in and referencing the current user
class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # Take the JSON parameters for email and password through params hash
  # and pass them to the AuthenticateUser command. If the command succeeds,
  # it will send the JWT token back to the user
  # POST /authenticate
  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end
end
