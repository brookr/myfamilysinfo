require 'test_helper'

class UpdatingSingleEventTest < ActionDispatch::IntegrationTest
  test 'update an existing event' do
    kid = kids(:Jimmy)
    event = reminders(:two)
    patch "/api/v1/kids/#{kid.id}/events/#{event.id}", { event: { name: 'hello world', type: "Medicine" } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 200, response.status
    assert_equal 'hello world', event.reload.name
  end

  test 'updating without a type returns an error' do
    kid = kids(:Jimmy)
    event = reminders(:two)
    patch "/api/v1/kids/#{kid.id}/events/#{event.id}", { event: { type: nil, datetime: 'something' } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 422, response.status
  end
end
