require 'test_helper'

class DeletingEventsTest < ActionDispatch::IntegrationTest
  test 'deleting an event' do
    kid = kids(:Jimmy)
    event = reminders(:two)
    delete "/api/v1/kids/#{kid.id}/events/#{event.id}"
    assert_equal 204, response.status
    assert_equal 5, Reminder.count
  end
end