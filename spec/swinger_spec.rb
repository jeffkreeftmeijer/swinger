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

end
