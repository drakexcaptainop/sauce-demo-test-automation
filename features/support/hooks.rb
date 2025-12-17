
After do 
    Capybara.current_session.driver.quit
end

Before '@maximize' do
  page.driver.browser.manage.window.maximize
end


Before('@dog-test') do |scenario|
    if(Gem.win_platform?)
        skip_this_scenario(scenario)
    end
end
