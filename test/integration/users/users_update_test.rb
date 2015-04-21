require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
  setup { @user = User.create!(email: "onlyatest@example.com", password: "mypassed") }

  test 'successful update' do
    patch "/api/v1/users/#{@user.id}", {
      email: 'testing@example.com',
      password: 'password'
    }.to_json,
    'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s

    assert_equal 200, response.status
    assert_equal 'testing@example.com', @user.reload.email
  end

  test 'update with invalid email' do
    patch "/api/v1/users/#{@user.id}", {
      email: 'testing.com',
      password: 'password'
    }.to_json,
    'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s

    assert_equal 422, response.status
  end

  test 'update with invalid password' do
    patch "/api/v1/users/#{@user.id}", {
      email: 'testing.@a.com',
      password: 'pass'
    }.to_json,
    'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s

    assert_equal 422, response.status
  end
end
