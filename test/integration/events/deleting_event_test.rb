require 'test_helper'

class DeletingEventsTest < ActionDispatch::IntegrationTest
  test 'deleting an event' do
    kid = kids(:Jimmy)
    event = reminders(:two)
    user = users(:liam)
    delete "/api/v1/kids/#{kid.id}/events/#{event.id}?auth_token=#{user[:authentication_token]}"
    assert_equal 204, response.status
    assert_equal 5, Reminder.count
  end

  test 'deleting an event that does not exist' do
    kid = kids(:Jimmy)
    event = reminders(:two)
    user = users(:liam)
    delete "/api/v1/kids/#{kid.id}/events/10?auth_token=#{user[:authentication_token]}"
    assert_equal 404, response.status
    assert_equal 6, Reminder.count
  end
end
