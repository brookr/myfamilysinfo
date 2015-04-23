require 'test_helper'
require 'api_helper'

class UsersTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  def test_user_creation_with_valid_data
    user_data = { email: 'test@example.com', password: 'password' }
    create_user user_data
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'user creation with blank email' do
    user_data = { email: nil, password: 'password' }
    create_user user_data
    assert_equal 422, response.status
  end

  test 'user creation with invalid email' do
    user_data = { email: 'me.com', password: 'password' }
    create_user user_data
    assert_equal 422, response.status
  end

  test 'user creation with invalid password' do
    user_data = { email: 'me@you.com', password: nil }
    create_user user_data
    assert_equal 422, response.status
  end
end
