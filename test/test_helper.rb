ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require "minitest/rails/capybara"
require "minitest/pride"
require 'simplecov'
SimpleCov.start

class ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  include Capybara::Assertions
end

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def json(body)
    JSON.parse(body, symbolize_names: true)
  end
end
def liam_sign_in(role = :editor)
  visit new_user_session_path
  fill_in "Email", with: users(:liam).email
  fill_in "Password",  with: "password"
  page.find("[type='submit']").click
end
def sign_in(role = :editor)
  visit new_user_session_path
  fill_in "Email", with: users(:mother).email
  fill_in "Password", with: "password"
  page.find("[type='submit']").click
end
