require "mixpanel_test_service"

# Mixpanel test service
Before "@mixpanel" do
  @mixpanel_test_service ||= MixpanelTest::Service.new(:port => 3001) # Don't shut this down until the end of the process. There are likely to be so many mixpanel tests that the overhead would be insane!
end
assert_not_nil(@last_mixpanel_event, "Mixpanel did not receive any \"#{event_name}\" events")
