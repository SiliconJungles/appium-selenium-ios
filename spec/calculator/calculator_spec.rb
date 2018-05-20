require 'appium_lib'
require 'byebug'
require 'spec_helper'

APP_PATH = 'app_test/TestApp-iphonesimulator.app'

describe "Calculator app", type: :feature do
  before(:all) do
    desired_caps = {
      caps: {
        platformName: 'iOS',
        deviceName:  'iPhone 6',
        platformVersion:  '10.3',
        app: APP_PATH,
        automationName: 'XCUITest',
      },
      appium_lib: {
        sauce_username: nil, # don't run on sauce
        sauce_access_key: nil,
        wait: 10,
      }
    }
    Appium::Driver.new(desired_caps).start_driver
    Appium.promote_appium_methods RSpec::Core::ExampleGroup
  end

  after(:all) do
    driver_quit
  end

  describe "App" do
    context "addition" do
      it "add two numbers" do
        find_element(name: "IntegerA").send_keys 4
        find_element(name: "IntegerB").send_keys 5
        find_element(name: "ComputeSumButton").click
        expect(find_element(name: "Answer").text).to eq "9"
      end
    end
  end
end