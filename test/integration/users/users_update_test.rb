require 'test_helper'
require 'api_helper'

class UsersTest < ActionDispatch::IntegrationTest
  test 'users can be updated' do
    user = users :liam
    user_object = { id: user.id, email: 'testing@example.com' }
    update_user user_object, user.authentication_token

    assert_equal 200, response.status
    json_response = JSON.parse(response.body, symbolize_names: true)
    assert_equal 'testing@example.com', json_response[:email]
  end

  test 'users cannot update other users' do
    user = users :liam
    other_user = users :mother

    update_user user, other_user.authentication_token

    assert_equal 404, response.status
  end
end
