require 'rspec/expectations'
require 'selenium-webdriver'
def sauce_capabilities
{
'app' => 'sauce-storage:game.zip',
'device' => 'iPhone Simulator',
'username' => 'qa_flo',
'access-key' => 'cc9860bc-eeec-40eb-bd36-3564878653bb',
'platform' => 'OS X 10.8',
'version' => '6.0',
'name' => 'Running PlainNote wit Cucumber and Appium',
'passed' => 'true'
}
end


def sauce_url
"http://qa_flo:cc9860bc-eeec-40eb-bd36-3564878653bb@ondemand.saucelabs.com:80/wd/hub" 
end


def sauce
@sauce ||= Selenium::WebDriver.for(:remote, :desired_capabilities => sauce_capabilities, :url => sauce_url)
end

After { @sauce.quit }
