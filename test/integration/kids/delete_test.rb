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
end
