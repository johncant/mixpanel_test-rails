module MixpanelTest
  class CucumberGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def generate_cucumber
      copy_file "mixpanel_steps.rb", "features/step_definitions/mixpanel_steps.rb"
      copy_file "mixpanel_test_service.rb", "features/support/mixpanel_test_service.rb"
      puts "(1a) If you're using the mixpanel gem, then set the config parameter :url to \"localhost:3001\" and the :test_service_hostname to \"localhost:3001\" (the johncant/mixpanel fork definitely contains these options)"
      puts "(1b) If you're not using the mixpanel gem, then replace the hostname in the Mixpanel javascript file url with \"localhost:3001\"."
      puts "PROFIT!!!!!! mixpanel_test_service will then hijack all the API data for the purpose of testing."
      puts "If that didn't work, please change this gem or mixpanel_test_service or mixpanel and submit a pull request."
    end
  end
end
