<h1>Purpose</h1>
<p>This gem provides some cucumber steps for use with <a href="https://github.com/johncant/mixpanel_test_service">mixpanel_test_service.</p>
<p>Feel free to add other types of test helpers</p>
<h2>Usage</h2>
<pre>
# Add this to your Gemfile
gem "mixpanel_test-rails"

# Run this
rails g mixpanel_test:cucumber # Generates cucumber steps and tells you how to set up the rest
</pre>

<h2>Having dependency problems?</h2>

<p>Not surprising. This relies on mixpanel_test_service from a git repo so it cannot yet be published. mixpanel_test_service cannot be published yet because it relies on a fork of net-http-server from a git repo. Just put the git repos in your Gemfile until the gem author or net-http-server publishes a particular bug fix</p>
