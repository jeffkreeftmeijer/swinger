$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'
require 'capybara/dsl'
require 'swinger'


describe RSpec::Core::Example do
  it 'should call Capybara.using_driver' do
    Capybara.should_receive(:use_driver).with(:capybara)

    RSpec::Core::Example.stub!(:metadata).and_return({:driver => :capybara})
    RSpec::Core::Example.run
  end
end

describe Capybara do
  it 'should set the driver using Capybara.current_driver=' do
    Capybara.should_receive(:current_driver=).with(:selenium)
    Capybara.using_driver(:selenium) {}
  end

  it 'should reset the driver using Capybara.use_default_driver' do
    Capybara.should_receive(:use_default_driver)
    Capybara.using_driver(:selenium) {}
  end

  it 'should yield the passed block' do
    Capybara.should_receive(:yeah)
    Capybara.using_driver(:selenium) { Capybara.yeah }
  end
end
