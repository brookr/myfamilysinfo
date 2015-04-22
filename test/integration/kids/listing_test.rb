require 'test_helper'
require 'api_helper'

class ListingTest < ActionDispatch::IntegrationTest
  test 'the index endpoint returns a list of kids for the user' do
    user = users(:mother)
    kid_names = user.kids.map(&:name)

    get_kids user.authentication_token
    assert_equal 200, response.status

    json_response = JSON.parse(response.body, symbolize_names: true)
    json_names = json_response.map { |k| k[:name] }
    kid_names.each do |name|
      assert_includes json_names, name
    end
  end

  test 'the index endpoint does not show kids belonging to different user' do
    user = users(:mother)
    other_user = users(:miles)
    kid_names = other_user.kids.map(&:name)

    get_kids user.authentication_token

    json_response = JSON.parse(response.body, symbolize_names: true)
    json_names = json_response.map { |k| k[:name] }
    kid_names.each do |name|
      refute_includes json_names, name
    end
  end

  test 'index cannot be accessed without token' do
    kid = kids(:Jimmy)

    get_kids kid
    assert_equal 401, response.status

    json_error = JSON.parse(response.body, symbolize_names: true)
    assert_equal "Authentication token missing or invalid", json_error[:message]
  end
end
