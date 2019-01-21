# frozen_string_literal: true

# This command takes the user's e-mail and password then returns the user, if
# the credentials match
class AuthenticateUser
  prepend SimpleCommand

  # Initializes a class instance with email and password attributes that are
  # accessible within the class
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  # Uses the credentials to check if the user exists in the database
  def user
    user = User.find_by_email(email)
    # If the user is found, the method uses the built-in authenticate method
    # and returns the user if everything is true
    return user if user && user.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    # returns nil if everything is not true in the above if statement
    nil
  end
end
