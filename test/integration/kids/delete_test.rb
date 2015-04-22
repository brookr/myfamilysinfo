require 'test_helper'
require 'api_helper'

class DeletingTest < ActionDispatch::IntegrationTest
  test 'kids can be deleted' do
    kid = kids(:Jimmy)

    delete_kid kid, users(:mother).authentication_token

    assert_equal 204, response.status
  end

  test 'cannot delete kids belonging to another user' do
    kid = kids :MilesJr
    user = users :mother

    delete_kid kid, user.authentication_token
    assert_equal 404, response.status
  end

  test 'error when trying to delete a non-existant kid' do
    kid = Kid.new(id: "Prince Humperdinck")

    delete_kid kid, users(:mother).authentication_token

    assert_equal 404, response.status
    json_error = JSON.parse(response.body, symbolize_names: true)
    assert_equal 'Object does not exist', json_error[:message]
  end

  test 'delete cannot be accessed without token' do
    kid = kids(:Jimmy)

    delete_kid kid
    assert_equal 401, response.status

    json_error = JSON.parse(response.body, symbolize_names: true)
    assert_equal "Authentication token missing or invalid", json_error[:message]
  end
end
