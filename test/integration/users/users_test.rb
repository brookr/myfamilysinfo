require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest

  setup { host! 'api.example.com' }

  def test_user_creation_with_valid_data
    post '/api/v1/users', { user: {
      name: 'me@example.com',
      password: 'password'
      } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.Content-Type

    user = json(response.body)
    assert_equal user_url(user[:id]), response.location


  end

  test 'it should update the user' do

  end
end
