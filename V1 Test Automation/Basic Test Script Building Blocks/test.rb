require 'selenium'

class OmegaHomePage < Selenium::WebPage

	def initialize(browser)
	super(browser, 'sandbox.omegaportal')
	end
	
	def title
	browser.get_title
	end
	
	def search_field
	text_field(:name, 'q')
	end
	
	def search_button
	button(:name, 'btnG')
	end

end

omega = OmegaHomePage.new('*firefox')
puts omega.title
