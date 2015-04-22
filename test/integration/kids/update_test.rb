require 'test_helper'
require 'api_helper'

class UpdatingTest < ActionDispatch::IntegrationTest
  test 'kids can be updated' do
    kid = kids(:Jimmy)

    kid.name = "Jenny"
    update_kid kid, users(:mother).authentication_token

    assert_equal 201, response.status
    json_kid = JSON.parse(response.body, symbolize_names: true)
    assert_equal json_kid[:name], kid.name
  end

  test 'cannot update kids belonging to another user' do
    kid = kids :MilesJr
    user = users :mother

    update_kid kid, user.authentication_token
    assert_equal 404, response.status
  end

  test 'update cannot be accessed without token' do
    kid = kids(:Jimmy)

    update_kid kid
    assert_equal 401, response.status

    json_error = JSON.parse(response.body, symbolize_names: true)
    assert_equal "Authentication token missing or invalid", json_error[:message]
  end
end
