require 'spec_helper'

describe 'Swinger' do

  describe RSpec::Core::Example do

    before do
      @group = RSpec::Core::ExampleGroup.describe
    end

    it 'should call Capybara.using_driver' do
      Capybara.should_receive(:using_driver).with(:selenium)
      @group.example("does something", {:driver => :selenium}).run
    end

    it "does not show the original aliased method" do
      methods = @group.example("without public aliased method").methods
      methods.should_not include('__run_before_swinger')
    end

  end

  describe Capybara do

    before do
      Capybara.current_driver.should_not == :selenium
    end

    it 'should set the driver using Capybara.current_driver=' do
      driver = nil
      Capybara.using_driver(:selenium) { driver = Capybara.current_driver }
      driver.should == :selenium
    end

    it 'should reset the driver using Capybara.use_default_driver, even if an exception occurs' do
      begin
        Capybara.using_driver(:selenium) { raise "ohnoes!" }
      rescue Exception
      end
      Capybara.current_driver.should == Capybara.default_driver
    end

    it 'should yield the passed block' do
      called = false
      Capybara.using_driver(:selenium) { called = true }
      called.should == true
    end

  end

end
