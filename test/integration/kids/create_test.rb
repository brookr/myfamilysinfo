require 'test_helper'

def create_kid(kid)
  post '/api/v1/kids', kid.attributes, 'Accept' => Mime::JSON
end

class CreatingTest < ActionDispatch::IntegrationTest
  test 'kids can be created' do
    kid = Kid.new(name: 'Bobby Joe')
    create_kid(kid)

    assert_equal 201, response.status
    json_kid = JSON.parse(response.body, symbolize_names: true)
    assert_equal json_kid[:name], kid.name
  end

  test 'kids cannot be created without a name' do
    kid = Kid.new
    create_kid(kid)

    assert_equal 422, response.status
    json_error = JSON.parse(response.body, symbolize_names: true)
    assert_equal 'Validation failed', json_error[:message]
    assert_equal 'missing_field', json_error[:errors][0][:code]
  end
end
