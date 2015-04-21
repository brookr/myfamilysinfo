require 'test_helper'

def delete_kid(kid)
  delete "/api/v1/kids/#{kid.id}", {}, { 'Accept' => Mime::JSON }
end

class DeletingTest < ActionDispatch::IntegrationTest
  test 'kids can be deleted' do
    kid = kids(:Jimmy)

    delete_kid(kid)

    assert_equal 204, response.status
  end

  test 'error when trying to delete a non-existant kid' do
    kid = Kid.new(id: "Prince Humperdinck")

    delete_kid(kid)

    assert_equal 404, response.status
    json_error = JSON.parse(response.body, symbolize_names: true)
    assert_equal 'Object does not exist', json_error[:message]
  end
end
