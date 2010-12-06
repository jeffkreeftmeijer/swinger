RSpec.configure do |c|

  c.around do |example|
    Capybara.using_driver(example.metadata[:driver]) { example }
  end

end

module Capybara

  def self.using_driver(driver)
    Capybara.current_driver = driver
    yield
  ensure
    Capybara.use_default_driver
  end

end
