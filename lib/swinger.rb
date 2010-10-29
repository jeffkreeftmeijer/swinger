class RSpec::Core::Example
  def self.run(*args)
    Capybara.use_driver(metadata[:driver])
  end
end

module Capybara
  def self.using_driver(driver, &block)
    Capybara.current_driver = driver
    yield
    Capybara.use_default_driver
  end
end
