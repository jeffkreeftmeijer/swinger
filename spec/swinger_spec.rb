require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe RSpec::Core::Example do

  before do
    class RSpec::Core::Example
      def run(*args); end
    end

    require 'swinger'
  end

  it 'should call Capybara.using_driver' do
    Capybara.should_receive(:use_driver).with(:capybara)

    RSpec::Core::Example.stub!(:metadata).and_return({:driver => :capybara})
    RSpec::Core::Example.run
  end

end
