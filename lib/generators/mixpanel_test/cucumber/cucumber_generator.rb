class MixpanelTest::CucumberGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def generate_cucumber
    copy_file "mixpanel_steps.rb", "features/step_definitions/mixpanel_steps.rb"
    puts "(1) Add this to your features/support/env.rb"
    puts File.read("#{File.expand_path('../templates', __FILE__)}/_env.rb")
    puts "(2) Change the mixpanel url to localhost:3001 or your favourite port. You can do this with the :url option if you're using the mixpanel gem"
    puts "(3) If that didn't work, change this gem and submit a pull request."
  end
end
