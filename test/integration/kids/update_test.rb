require 'test_helper'
require 'api_helper'

class UpdatingTest < ActionDispatch::IntegrationTest
  test 'kids can be updated' do
    kid = kids(:Jimmy)

    kid.name = "Jenny"
    update_kid(kid)

    assert_equal 201, response.status
    json_kid = JSON.parse(response.body, symbolize_names: true)
    assert_equal json_kid[:name], kid.name
  end
end
