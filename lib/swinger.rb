if defined? RSpec::Core::Example
  class RSpec::Core::Example

    alias_method :__run_before_swinger, :run
    private :__run_before_swinger

    def run(*args)
      Capybara.using_driver(metadata[:driver]) { __run_before_swinger(*args) }
    end

  end
end

module Capybara

  def self.using_driver(driver)
    Capybara.current_driver = driver
    yield
    Capybara.use_default_driver
  end

end
