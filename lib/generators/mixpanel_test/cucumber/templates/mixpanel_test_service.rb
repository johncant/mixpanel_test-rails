# Mixpanel test service.
# Use this with my Mixpanel gem fork (johncant/mixpanel) or replace the mixpanel javascript file url hostname with localhost:3001. This will proxy the Mixpanel javascript file through the Mixpanel test service, which will edit it slightly. Then, all Mixpanel API calls will go to the Mixpanel test service instead, where you can run tests on them.
require "mixpanel_test/service"

mixpanel_test_service = nil

Before "@mixpanel" do
  mixpanel_test_service ||= MixpanelTest::Service.new(:port => 3001) # Don't shut this down until the end of the process. There are likely to be so many mixpanel tests that the overhead would really slow down the tests.
  @mixpanel_test_service = mixpanel_test_service

  @mixpanel_test_service.transaction do
    @mixpanel_test_service.events.clear
  end
end
at_exit do
  mixpanel_test_service.stop
  Thread.pass until mixpanel_test_service.stopped?
end
