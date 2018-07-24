Feature: Notes 
  As iOS automation specialist 
  I want to setup iOS app automation in the cloud using Saucelabs, Appium and cucumber 
Scenario: Add new Note using PlainNote App


Given I have App running with appium on Sauce
When click + button using sauce driver
And I enter text "Data" and saved it on sauce
Then I should see "Data" note added on home page in the sauce cloud
