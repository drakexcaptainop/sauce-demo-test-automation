begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'mini_magick'
require 'selenium-webdriver'
require 'digest'

#PTravel Settings
ENV['USER']="Pepazo"
ENV['PSW']="ILoveQA"
ENV['tax_percentage'] = "0.08"

raw_image_bytes = MiniMagick::Image.open('dog.jpg').get_pixels.flatten.pack('C*')
ENV['image_hash'] = Digest::MD5.hexdigest(raw_image_bytes)

Capybara.default_driver = :selenium

# Set the host the Capybara tests should be run against
Capybara.app_host = ENV["CAPYBARA_HOST"]

# Set the time (in seconds) Capybara should wait for elements to appear on the page
Capybara.default_max_wait_time = 15
Capybara.default_driver = :selenium
Capybara.app_host = "https://www.saucedemo.com"

class CapybaraDriverRegistrar
  # register a Selenium driver for the given browser to run on the localhost
  def self.register_selenium_driver(browser)
    Capybara.register_driver :selenium do |app|
      
      options = nil
      
      if browser == :chrome
        # 2. Use '::Selenium' to force Ruby to look at the top-level module
        options = ::Selenium::WebDriver::Chrome::Options.new
        
        # Silence the logs
        options.add_argument('--log-level=3')
        options.add_argument('--silent')
        
        # Stability fix
        options.add_argument('--disable-gpu')
      end

      # Pass the options to the driver
      Capybara::Selenium::Driver.new(app, browser: browser, options: options)
      
    end
  end
end
# Register various Selenium drivers
#CapybaraDriverRegistrar.register_selenium_driver(:internet_explorer)
#CapybaraDriverRegistrar.register_selenium_driver(:firefox)
CapybaraDriverRegistrar.register_selenium_driver(:chrome)
Capybara.run_server = false
#World(Capybara)

Capybara::Screenshot.autosave_on_failure = false