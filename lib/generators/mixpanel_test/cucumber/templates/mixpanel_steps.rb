# Check that Mixpanel received any event
Then /^(?:|Mixpanel should receive an event)$/ do
  @mixpanel_test_service.transaction do
    @last_mixpanel_event = @mixpanel_test_service.events.shift
  end

  assert_not_nil(@last_mixpanel_event, "Mixpanel did not receive any events")
end

# Check that Mixpanel received a specific event
Then /^(?:|Mixpanel should receive a "([^\"]*)" event)$/ do |event_name|
  @mixpanel_test_service.transaction do
    matching_events = @mixpanel_test_service.events.find_all do |ev|
      ev["event"] == event_name
    end
    assert matching_events.count <= 1, "More than one \"#{event_name}\" events were received"
    @last_mixpanel_event = @mixpanel_test_service.delete(matching_events.first)
  end
end
