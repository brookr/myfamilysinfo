require 'test_helper'

class UpdatingSingleEventTest < ActionDispatch::IntegrationTest
  before do
    @user = users(:liam)
    @kid = kids(:Jimmy)
    @medicine     = Reminder.create!({ type: 'Medicine', meds: 'Tylenol 2 pills' })
    @heightweight = Reminder.create!({ type: 'HeightWeight', height: "3'10", weight: '85 lbs' })
    @temperature  = Reminder.create!({ type: 'Temperature', temperature: '98.6' })
    @symptom      = Reminder.create!({ type: 'Symptom', description: 'Bumps on Arms' })
  end

  test 'update an existing Meidicine event' do
    patch "/api/v1/kids/#{@kid.id}/events/#{@medicine.id}?auth_token=#{@user[:authentication_token]}", { event: { meds: '3 pills' } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 200, response.status
    assert_equal '3 pills', @medicine.reload.meds
  end

  test 'update Medicine event without an amount raises error' do
    patch "/api/v1/kids/#{@kid.id}/events/#{@medicine.id}?auth_token=#{@user[:authentication_token]}", { event: { meds: nil } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 422, response.status
  end

  test 'update an existing HeightWeight event with new weight' do
    patch "/api/v1/kids/#{@kid.id}/events/#{@heightweight.id}?auth_token=#{@user[:authentication_token]}", { event: { weight: '99 lbs' } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 200, response.status
    assert_equal '99 lbs', @heightweight.reload.weight
    assert_equal "3'10", @heightweight.reload.height
  end

  test 'update an existing HeightWeight event with new height' do
    patch "/api/v1/kids/#{@kid.id}/events/#{@heightweight.id}?auth_token=#{@user[:authentication_token]}", { event: { height: "4'0" } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 200, response.status
    assert_equal '85 lbs', @heightweight.reload.weight
    assert_equal "4'0", @heightweight.reload.height
  end

  test 'update HeightWeight event without a height or weight raises error' do
    patch "/api/v1/kids/#{@kid.id}/events/#{@heightweight.id}?auth_token=#{@user[:authentication_token]}", { event: { height: nil, weight: nil } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 422, response.status
  end

  test 'update an existing Temperature event with new temperature' do
    patch "/api/v1/kids/#{@kid.id}/events/#{@temperature.id}?auth_token=#{@user[:authentication_token]}", { event: { temperature: "99.6" } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 200, response.status
    assert_equal '99.6', @temperature.reload.temperature
  end

  test 'update an existing Temperature event without a temperature raises an error' do
    patch "/api/v1/kids/#{@kid.id}/events/#{@temperature.id}?auth_token=#{@user[:authentication_token]}", { event: { temperature: nil } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 422, response.status
  end

  test 'update an existing Symptom event with a new description' do
    patch "/api/v1/kids/#{@kid.id}/events/#{@symptom.id}?auth_token=#{@user[:authentication_token]}", { event: { description: 'Bumps on legs' } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 200, response.status
    assert_equal 'Bumps on legs', @symptom.reload.description
  end

  test 'update an existing Symptom event without a new description raises an error' do
    patch "/api/v1/kids/#{@kid.id}/events/#{@symptom.id}?auth_token=#{@user[:authentication_token]}", { event: { description: nil } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 422, response.status
  end

  test 'updating without a type returns an error' do
    event = reminders(:two)
    patch "/api/v1/kids/#{@kid.id}/events/#{event.id}?auth_token=#{@user[:authentication_token]}", { event: { type: nil, datetime: 'something' } },
          { 'Accept' => 'application/json',
            'Content_type' => 'application/json' }
    assert_equal 422, response.status
  end
end
