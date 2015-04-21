require 'test_helper'

class CreatingEventsTest < ActionDispatch::IntegrationTest
  before do
    @kid = Kid.create!({ name: 'Tyler' })
  end

  test 'creating a new Medicine event' do
    post "/api/v1/kids/#{@kid.id}/events",
         { name: 'Tylenol', type: 'Medicine',
           amount: '2 pills',
           datetime: '20-04-2015T12:20:00' }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)
    assert_equal api_v1_kid_events_url(event[:id]), response.location
    assert_equal 'Tylenol', event[:name]
    assert_equal '2 pills', event[:amount]
    assert_equal '20-04-2015T12:20:00', event[:datetime]
  end

  test 'does not create a Medicine event without a name' do
    post "/api/v1/kids/#{@kid.id}/events",
         { type: 'Medicine', amount: '1 pill' }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 422, response.status
  end

  test 'does not create a Medicine event without an amount' do
    post "/api/v1/kids/#{@kid.id}/events",
         { type: 'Medicine', name: 'Aspirin' }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 422, response.status
  end

  test 'creating a new Symptom event' do
    post "/api/v1/kids/#{@kid.id}/events",
         { type: 'Symptom', description: 'Bumps on arm' }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    event = json(response.body)
    assert_equal api_v1_kid_events_url(event[:id]), response.location
    assert_equal 'Bumps on arm', event[:description]
  end

  test 'does not create event without a type' do
    post "/api/v1/kids/#{@kid.id}/events",
         { type: nil }.to_json,
         { 'Accept' => 'application/json',
           'Content-Type' => 'application/json' }

    assert_equal 422, response.status
  end


end
