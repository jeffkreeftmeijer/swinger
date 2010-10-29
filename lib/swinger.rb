class RSpec::Core::Example
  def self.run(*args)
    Capybara.use_driver(metadata[:driver])
  end
end
