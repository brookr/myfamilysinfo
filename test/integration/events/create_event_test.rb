require 'test_helper'

class CreatingEventsTest < ActionDispatch::IntegrationTest
  before do
    @user = users(:liam)
    @kid = kids(:Jimmy)
  end

  test 'creating a new Medicine event' do
    post "/api/v1/kids/#{@kid.id}/events?auth_token=#{@user[:authentication_token]}",
         { meds: 'Tylenol 2 pills', type: 'Medicine',
           datetime: '20-04-2015T12:20:00' }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)
    assert_equal 'Tylenol 2 pills', event[:meds]
    assert_equal '20-04-2015T12:20:00', event[:datetime]
  end

  test 'does not create a Medicine event without meds' do
    post "/api/v1/kids/#{@kid.id}/events?auth_token=#{@user[:authentication_token]}",
         { type: 'Medicine', meds: nil }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 422, response.status
  end

  test 'creating a new Symptom event' do
    post "/api/v1/kids/#{@kid.id}/events?auth_token=#{@user[:authentication_token]}",
         { type: 'Symptom', description: 'Bumps on arm' }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)
    assert_equal 'Bumps on arm', event[:description]
  end

  test 'does not create a symptom without a description' do
    post "/api/v1/kids/#{@kid.id}/events?auth_token=#{@user[:authentication_token]}",
         { type: 'Symptom', description: nil }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 422, response.status
  end

  test 'create a new temperature event' do
    post "/api/v1/kids/#{@kid.id}/events?auth_token=#{@user[:authentication_token]}",
         { type: 'Temperature', temperature: '98.6' }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)
    assert_equal '98.6', event[:temperature]
  end

  test 'does not create a temperature event without a temperature' do
    post "/api/v1/kids/#{@kid.id}/events?auth_token=#{@user[:authentication_token]}",
         { type: 'Temperature', temperature: nil }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 422, response.status
  end

  test 'create a new HeightWeight event with a height and a weight' do
    post "/api/v1/kids/#{@kid.id}/events?auth_token=#{@user[:authentication_token]}",
         { type: 'HeightWeight', height: "4'2", weight: "100 lbs" }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)
    assert_equal '100 lbs', event[:weight]
    assert_equal "4'2", event[:height]
  end

  test 'create a HeightWeight event without a height' do
    post "/api/v1/kids/#{@kid.id}/events?auth_token=#{@user[:authentication_token]}",
         { type: 'HeightWeight', weight: '100 lbs' }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)
    assert_equal '100 lbs', event[:weight]
  end

  test 'create a HeightWeight event without a weight' do
    post "/api/v1/kids/#{@kid.id}/events?auth_token=#{@user[:authentication_token]}",
         { type: 'HeightWeight', height: "4'2" }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)
    assert_equal "4'2", event[:height]
  end

  test 'does not create a HeightWeight event without either a height or a weight' do
    post "/api/v1/kids/#{@kid.id}/events?auth_token=#{@user[:authentication_token]}",
         { type: "HeightWeight" }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 422, response.status
  end

  test 'does not create event without a type' do
    post "/api/v1/kids/#{@kid.id}/events?auth_token=#{@user[:authentication_token]}",
         { type: nil }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 422, response.status
  end
end
