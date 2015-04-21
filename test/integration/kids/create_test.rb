require 'test_helper'

def create_kid(kid)
  post '/api/v1/kids', kid, { 'Accept' => Mime::JSON }
end

class CreatingTest < ActionDispatch::IntegrationTest
  test 'kids can be created' do
    create_kid(name: 'Bobby Joe')

    assert_equal 201, response.status
    json_kid = JSON.parse(response.body, symbolize_names: true)
    assert_equal json_kid[:name], 'Bobby Joe'
  end
end
