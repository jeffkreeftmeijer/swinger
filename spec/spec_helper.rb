$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'capybara/dsl'
require 'swinger'

# stolen from rspec-core's spec/spec_helper.rb

def sandboxed(&block)
  begin
    @orig_config = RSpec.configuration
    @orig_world  = RSpec.world
    new_config = RSpec::Core::Configuration.new
    new_config.include(RSpec::Matchers)
    new_world  = RSpec::Core::World.new(new_config)
    RSpec.instance_variable_set(:@configuration, new_config)
    RSpec.instance_variable_set(:@world, new_world)
    object = Object.new
    object.extend(RSpec::Core::ObjectExtensions)
    object.extend(RSpec::Core::SharedExampleGroup)

    (class << RSpec::Core::ExampleGroup; self; end).class_eval do
      alias_method :orig_run, :run
      def run(reporter=nil)
        @orig_mock_space = RSpec::Mocks::space
        RSpec::Mocks::space = RSpec::Mocks::Space.new
        orig_run(reporter || NullObject.new)
      ensure
        RSpec::Mocks::space = @orig_mock_space
      end
    end

    object.instance_eval(&block)
  ensure
    (class << RSpec::Core::ExampleGroup; self; end).class_eval do
      remove_method :run
      alias_method :run, :orig_run
      remove_method :orig_run
    end

    RSpec.instance_variable_set(:@configuration, @orig_config)
    RSpec.instance_variable_set(:@world, @orig_world)
  end
end

RSpec.configure do |c|
  c.around do |example|
    sandboxed { example.run }
  end
end
