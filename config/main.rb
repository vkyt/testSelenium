require "rubygems" #all the require statements should be here
require "watir"
require "cucumber"
require 'selenium-webdriver'

#kill any existing browser sessions for a clean start
system 'pkill firefox'
system 'pkill chrome'

$logger = Logger.new(STDERR)
$logger = Logger.new(STDOUT)

$logger = Logger.new("#{File.dirname(__FILE__)}/../logs/watir.log", 'weekly')

if ENV['HEADLESS'] == 'true'
  require 'headless'

  headless = Headless.new
  headless.start
  $logger.info('Starting Headless')
  $isheadless='true'
    at_exit do
      headless.destroy
      $logger.close

    end
  else
    at_exit do
      $logger.close
    end
    $isheadless='false'
end

$site_prefix = 'default'
case ENV['SITE']
  when 'local'
    $site_prefix='local'
  when 'dev5'
    $site_prefix='dev5'    
  else
    $logger.info("SITE is not configured in profile")
end

CONFIG = YAML.load_file("#{File.dirname(__FILE__)}/config.yml")


Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each { |f| require f } 
#load all the lib files

Dir["#{File.dirname(__FILE__)}/../pages/**/*.rb"].each { |f| require f } # all page functions are loaded

@After
After do |scenario|
  if(scenario.failed?)
      _fileTime = Time.new.strftime("%Y-%m-%d_%H-%M-%S")
      $browser.driver.save_screenshot "#{File.dirname(__FILE__)}/../screenshots/after_#{_fileTime}.png"
      embed "#{File.dirname(__FILE__)}/../screenshots/after_#{_fileTime}.png",'image/png'
  end
end  

#profile = Selenium::WebDriver::Firefox::Profile.new
#profile['browser.cache.disk.enable'] = false
#$browser = Watir::Browser.new  :firefox, :profile => profile
$browser = Watir:Browser.mew :chrome
$browser.cookies.clear
$browser.driver.manage.timeouts.implicit_wait = 5
$browser.driver.manage.window.maximize


