require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
  setup { host! 'api.example.com' }

  def test_user_creation_with_valid_data
    post '/api/v1/users', {
      email: 'test123@example.com',
      password: 'password'
    }.to_json,
    'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    user = json(response.body)
    assert_equal user_url(user[:id]), response.location
  end

  test 'user creation with blank email' do
    post '/api/v1/users', {
      email: '',
      password: 'password'
    }.to_json,
    'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s

    assert_equal 500, response.status
  end

  test 'user creation with invalid email' do
    post '/api/v1/users', {
      email: 'me.com',
      password: 'password'
    }.to_json,
    'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s

    assert_equal 500, response.status
  end

  test 'user creation with invalid password' do
    post '/api/v1/users', {
      email: 'me@you.com',
      password: ''
    }.to_json,
    'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s

    assert_equal 500, response.status
  end
end
