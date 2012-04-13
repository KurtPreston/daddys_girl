require 'spec_helper'

describe DaddysGirl do
  before(:all) do
    FactoryGirl.define do
      factory :test_class do
        name 'Test Name'
      end
    end
  end

  before(:each) do
    define_model('TestClass', {:name => :string})
  end

  describe "ActiveRecord::Base.spawn" do
    it "creates a new object without saving" do
      TestClass.spawn(:name => "Test Name").name.should == "Test Name"
      TestClass.spawn.id.should be_nil
    end
  end

  describe "ActiveRecord::Base.generate" do
    context "if the object is valid" do
      it "creates a new object and saves" do
        TestClass.generate(:name => "Test Name").name.should == "Test Name"
        TestClass.generate.id.should_not be_nil
      end
    end

    context "if the object is not valid" do
      it "creates a new object without saving" do
        pending
      end
    end
  end

  describe "ActiveRecord::Base.generate!" do
    context "if the object is valid" do
      it "creates a new object and saves" do
        TestClass.generate!(:name => "Test Name").name.should == "Test Name"
        TestClass.generate!.id.should_not be_nil
      end
    end

    context "if the object is not valid" do
      it "throws an error" do
        pending
      end
    end
  end
end
