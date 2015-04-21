require 'test_helper'

class ShowTest < ActionDispatch::IntegrationTest
  test 'the show endpoint returns a single kid' do
    kid = kids(:Jimmy)

    get "/api/v1/kids/#{kid.id}", {}, { 'Accept' => Mime::JSON }
    assert_equal 200, response.status

    json_kid = JSON.parse(response.body, symbolize_names: true)
    assert_equal json_kid[:name], kid.name
    assert_equal json_kid[:dob], kid.dob
  end
end
