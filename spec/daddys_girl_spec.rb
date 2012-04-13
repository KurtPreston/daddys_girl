require 'spec_helper'

describe DaddysGirl do
  it "successfully spawns" do
    define_model('TestClass', {:name => :string})

    FactoryGirl.define do
      factory :test_class do
        name 'Test Name'
      end
    end

    FactoryGirl.create(:test_class)

    TestClass.bogusunder.name.should == "Test Name"
    TestClass.spawn.id.should be_nil
  end
end
