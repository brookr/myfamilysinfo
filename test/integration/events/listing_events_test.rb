require 'test_helper'

class ListingEventsTest < ActionDispatch::IntegrationTest
  test 'listing all the events for a given kid' do
    kid = kids(:Jimmy)
    get "/api/v1/kids/#{kid.id}/events"
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    json(response.body)
    assert_equal 2, json(response.body).size
  end
end
