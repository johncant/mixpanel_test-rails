# Mixpanel test service.
# Use this with my Mixpanel gem fork (johncant/mixpanel) or replace the mixpanel javascript file url hostname with localhost:3001. This will proxy the Mixpanel javascript file through the Mixpanel test service, which will edit it slightly. Then, all Mixpanel API calls will go to the Mixpanel test service instead, where you can run tests on them.
require "mixpanel_test/service"
require "test/unit"

module MixpanelTestHelpers
  mattr_accessor :mixpanel_test_service

  def mixpanel_synchronize_until(secs = 2)
    start_time = Time.now

    until (res=yield) || Time.now >= start_time+2.seconds
      sleep 0.05
    end

    res || nil
  end

end

World(MixpanelTestHelpers)

Before "@mixpanel" do
  begin
    MixpanelTestHelpers.mixpanel_test_service ||= MixpanelTest::Service.new(:port => 3001) # Don't shut this down until the end of the process. There are likely to be so many mixpanel tests that the overhead would really slow down the tests.
    MixpanelTestHelpers.mixpanel_test_service.transaction do
      MixpanelTestHelpers.mixpanel_test_service.events.clear
    end
  rescue
    MixpanelTestHelpers.mixpanel_test_service = nil
  end
end

at_exit do
  if MixpanelTestHelpers.mixpanel_test_service
    MixpanelTestHelpers.mixpanel_test_service.stop
    Thread.pass until MixpanelTestHelpers.mixpanel_test_service.stopped?
  end
end

