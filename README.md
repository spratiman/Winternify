# Winternify
Shopify Summer 2019 Developer Intern [Challenge](https://bit.ly/2Mk5wvf)

## ER Diagram
![ER Diagram](public/entityrelationship.jpg)

## Framework
* Rails 5.2.2
* Ruby 2.6.0

## Setup
1. Make sure `ruby -v` and `rails -v` return appropriate values to ensure that Ruby and Rails are installed
2. Clone the git repository: `git clone https://github.com/spratiman/Winternify.git`
3. Install all dependencies: `bundle install`
4. Create db, migrate schema and pre-populate products and users table:
    1. `rake db:create`
    2. `rake db:migrate`
    3. `rake db:seed`
5. Run application: `rails s`

PS: Sorry about this lengthy setup process but my attempt to host this service on Heroku failed multiple times!

## REST API

API Documentation: [documentation](https://documenter.getpostman.com/view/2741447/RzteTYFp)

## Steps
1. API can be tested with Postman by replicating the calls in the above API Documentation

2. User needs to authenticate with a token before making any API calls:
    1. Open Postman
    2. Create a POST request with the following details:
        URL: http://0.0.0.0:3000/authenticate
        Headers: `Content-Type: application/json`
        Body: `{"email": "pratiman@winternify.com", "password": "summer2019"}`
    3. Copy the `auth_token` from the response field
    4. Select the Authorization tab in a new request, and select the Type as "Bearer Token" and Paste the copied token in the "token" field
