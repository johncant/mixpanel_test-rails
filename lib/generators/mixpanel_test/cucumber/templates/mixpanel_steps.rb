#When

# Ignore a mixpanel event
When /^I discard that Mixpanel event$/ do
  ev = nil
  @mixpanel_test_service.transaction do
    ev = @mixpanel_test_service.events.shift
  end

  assert_not_nil(ev, "Mixpanel did not receive any events")

end

# Check that Mixpanel received any event
Then /^(?:|Mixpanel )should receive an event$/ do
  @mixpanel_test_service.transaction do
    @last_mixpanel_event = @mixpanel_test_service.events.shift
    assert_not_nil(@last_mixpanel_event, "Mixpanel did not receive any events")
  end
end

# Check that Mixpanel received a specific event
Then /^(?:|Mixpanel )should receive (?:|a|an) "([^\"]*)" event$/ do |event_name|
  @mixpanel_test_service.transaction do
    matching_events = @mixpanel_test_service.events.find_all do |ev|
      ev["event"] == event_name
    end
    assert matching_events.count <= 1, "More than one \"#{event_name}\" events were received"
    assert_not_nil matching_events.first, "Mixpanel did not receive any events"
    @last_mixpanel_event = @mixpanel_test_service.events.delete(matching_events.first)
  end
end

# Check that a page visit was recorded
Then /^(?:|Mixpanel )should track (?:|the |a )page(?:| visit| view| hit)$/ do
  step "Mixpanel should receive a \"mp_page_view\" event" # TODO - find out the exact event name
end

Then /^(?:|Mixpanel )should see "([^\"]*)" (?:|as |for )the "([^\"]*)" property$/ do |value, key|
  assert_equal value, @last_mixpanel_event["properties"][key]
end

# Check that Mixpanel will show something up in the stream
Then /^(?:|Mixpanel )should show "([^\"]*)" in the stream(?: and (?:|as |for )the "([^\"]*)" property)?$/ do |value, key|
  step "Mixpanel should see \"#{value}\" as the \"mp_notes\" property"
  step "Mixpanel should see \"#{value}\" as the \"#{key}\" property" if key
end

# Check that a url is used as a Mixpanel property
Then /^(?:|Mixpanel )should see the url for (.+?) (?:|as |for )the "([^\"]*)" property$/ do |path, key|
  step "Mixpanel should see \"#{path_to(path)}\" as the \"#{key}\" property"
end
