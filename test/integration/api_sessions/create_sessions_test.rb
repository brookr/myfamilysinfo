require 'test_helper'
require 'api_helper'

class CreateSessionsTest < ActionDispatch::IntegrationTest
  test 'successful session creation' do
    create_session email: "user@example.com", password: "password"
    assert_equal 201, response.status
  end

  test 'unsuccessful session creation' do
    create_session email: "user@example.com", password: "pass"
    assert_equal 401, response.status
  end
end
