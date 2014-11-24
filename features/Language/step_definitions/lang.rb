require "#{File.dirname(__FILE__)}/../../../config/main.rb" #including main.rb starts the process

Given(/^that I am on "(.*?)"$/) do |browser|
	case browser.upcase
	when "CHROME" then
    $browser = Watir::Browser.new :chrome
    $browser.cookies.clear
    $browser.driver.manage.timeouts.implicit_wait = 5
    $browser.driver.manage.window.maximize
	when "FIREFOX" then
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['browser.cache.disk.enable'] = false
    $browser = Watir::Browser.new  :firefox, :profile => profile
    $browser.cookies.clear
    $browser.driver.manage.timeouts.implicit_wait = 5
    $browser.driver.manage.window.maximize
	else 
	  #if no browser is found, use default - firefox
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['browser.cache.disk.enable'] = false
    $browser = Watir::Browser.new  :firefox, :profile => profile
    $browser.cookies.clear
    $browser.driver.manage.timeouts.implicit_wait = 5
    $browser.driver.manage.window.maximize
	end
end

When(/^I go to the flyertown "(.*?)" and choose "(.*?)"$/) do |page, lang|
  #Go to the page specified and choose the language
  $logger.info("Navigate to Page and Language specified: " + page + " - " + lang)
  case lang.downcase
  when "en"
    $browser.goto General.constructURL(page)+"?locale=en"
  when "fr"
    $browser.goto General.constructURL(page)+"?locale=fr"
  end
end

Then(/^I should see the "(.*?)" displayed$/) do |lang|
  # verify the language
  General.verifyLang(lang).should ==true
  $browser.close
end
