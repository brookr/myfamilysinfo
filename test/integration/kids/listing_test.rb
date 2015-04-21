require 'test_helper'
require 'api_helper'

class ListingTest < ActionDispatch::IntegrationTest
  test 'the index endpoint returns a list of kids' do
    kid_names = Kid.all.map(&:name)

    get_kids
    assert_equal 200, response.status

    json_response = JSON.parse(response.body, symbolize_names: true)
    json_names = json_response.map { |k| k[:name] }
    kid_names.each do |name|
      assert_includes json_names, name
    end
  end
end
