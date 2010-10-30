class RSpec::Core::Example
  run = self.instance_method(:run)

  define_method(:run) do |*args|
    Capybara.using_driver(metadata[:driver]) { run.bind(self).call(*args) }
  end

end

module Capybara

  def self.using_driver(driver, &block)
    Capybara.current_driver = driver
    yield
    Capybara.use_default_driver
  end

end
