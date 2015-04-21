require 'test_helper'

class ListingTest < ActionDispatch::IntegrationTest
  test 'the index endpoint returns a list of kids' do
    kid_names = Kid.all.map(&:name)

    get '/api/v1/kids', {}, { 'Accept' => Mime::JSON }
    assert_equal 200, response.status

    json_response = JSON.parse(response.body, symbolize_names: true)
    json_names = json_response.map(&:name)
    kid_names.each do |name|
      assert_includes json_names, name
    end
  end
end
