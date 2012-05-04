require "test/unit"
require "rubygems"
gem "selenium-client"
require "selenium/client"

class RegisterJoeSmith < Test::Unit::TestCase

  def setup
    @verification_errors = []
    @selenium = Selenium::Client::Driver.new \
      :host => "localhost",
      :port => 4444,
      :browser => "*firefox",
      :url => "http://sandbox.omegaportal.org/",
      :timeout_in_second => 60,
		:jar_file => '/home/I829287/omega-tests/omega-tests/server'

    @selenium.start_new_browser_session
  end
  
  def teardown
    @selenium.close_current_browser_session
    assert_equal [], @verification_errors
  end
  
  def test_register_joe_smith
    @selenium.open "http://sandbox.omegaportal.org"
    @selenium.click "//div[@id='ctlrBar']/a/span"
    @selenium.wait_for_page_to_load "30000"
    @selenium.type "user_contact_attributes_first_name", "Joe"
    @selenium.type "user_contact_attributes_last_name", "Smith"
    @selenium.type "id=user_contact_attributes_birthday", "05/22/1992"
    @selenium.type "user_contact_attributes_addresses_attributes_0_city", "Anywhere"
    @selenium.type "user_contact_attributes_addresses_attributes_0_zip_code", "12345"
    @selenium.type "user_contact_attributes_phone_numbers_attributes_0_number", "978999888"
    @selenium.type "user_contact_attributes_email", "paul.miller01@sap.com"
    @selenium.type "user_contact_attributes_email_confirmation", "paul.miller01@sap.com"
    @selenium.type "user_username", "joe"
    @selenium.type "user_password", "smith"
    @selenium.type "user_password_confirmation", "smith"
    @selenium.click "user_submit"
    @selenium.wait_for_page_to_load "30000"
    begin
        assert @selenium.is_text_present("Hello Joe!")
    rescue Test::Unit::AssertionFailedError
        @verification_errors << $!
    end
  end
end
