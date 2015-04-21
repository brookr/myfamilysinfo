require 'test_helper'
require 'api_helper'

class ShowTest < ActionDispatch::IntegrationTest
  test 'the show endpoint returns a single kid' do
    kid = kids(:Jimmy)

    get_kid kid, users(:mother).authentication_token
    assert_equal 200, response.status

    json_kid = JSON.parse(response.body, symbolize_names: true)
    assert_equal json_kid[:name], kid.name
    assert_equal json_kid[:dob], kid.dob.strftime("%d-%m-%Y")
  end

  test 'show cannot be accessed without token' do
    kid = kids(:Jimmy)

    get_kid kid
    assert_equal 401, response.status

    json_error = JSON.parse(response.body, symbolize_names: true)
    assert_equal "Authentication token missing or invalid", json_error[:message]
  end
end
