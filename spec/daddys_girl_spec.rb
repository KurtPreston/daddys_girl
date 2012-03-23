require 'spec_helper'

describe DaddysGirl do
  it "successfully spawns" do
    FactoryGirl.create(:test_class)

    TestClass.spawn.name.should == "Test Name"
    TestClass.spawn.id.should be_nil
  end
end
