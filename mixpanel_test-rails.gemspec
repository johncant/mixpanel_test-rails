# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mixpanel_test/version"

Gem::Specification.new do |s|
  s.name        = "mixpanel_test-rails"
  s.version     = MixpanelTest::VERSION
  s.authors     = ["John Cant"]
  s.email       = ["a.johncant@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Cucumber steps for testing mixpanel integration}
  s.description = %q{Cucumber steps for testing mixpanel integration}

  s.rubyforge_project = "mixpanel_test-rails"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  s.add_runtime_dependency "mixpanel_test_service"
  s.add_runtime_dependency "rails", ">= 3.0.0"
end
