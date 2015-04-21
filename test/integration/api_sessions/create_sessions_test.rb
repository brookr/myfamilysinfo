require "test_helper"

class CreateSessionsTest < ActionDispatch::IntegrationTest
  setup { @user = User.create!(email: "us@example.com", password: "password") }

  test 'successful session creation' do
    post "/api/v1/sessions/", {
      email: 'us@example.com',
      password: 'password'
    }.to_json,
    'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    puts json(response.body)
    assert_equal 201, response.status
  end

  test 'unsuccessful session creation' do
    post "/api/v1/sessions/", {
      email: 'us@example.com',
      password: 'pass'
    }.to_json,
    'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    puts json(response.body)
    assert_equal 401, response.status
  end
end
