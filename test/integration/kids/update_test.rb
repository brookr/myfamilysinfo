require 'test_helper'

def update_kid(kid)
  patch "/api/v1/kids/#{kid.id}", kid.attributes, 'Accept' => Mime::JSON
end

class UpdatingTest < ActionDispatch::IntegrationTest
  test 'kids can be updated' do
    kid = kids(:Jimmy)

    kid.name = "Jenny"
    update_kid(kid)

    assert_equal 201, response.status
    json_kid = JSON.parse(response.body, symbolize_names: true)
    assert_equal json_kid[:name], kid.name
  end

  test 'kids cannot be updated with invalid data' do
    kid = kids(:Jimmy)

    kid.dob = Date.today + 10
    update_kid(kid)

    assert_equal 422, response.status
    json_error = JSON.parse(response.body, symbolize_names: true)
    assert_equal 'Validation failed', json_error[:message]
    assert_equal 'invalid_field', json_error[:errors][0][:code]
  end
end
