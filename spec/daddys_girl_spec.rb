require 'spec_helper'

describe DaddysGirl do
  before(:all) do
    FactoryGirl.define do
      factory :test_class do
        name 'Test Name'
      end

      factory :test_association do
        name 'Association'
      end
    end
  end

  before(:each) do
    define_model('TestClass', {:name => :string})
    define_model('TestAssociation', {:name => :string, :test_class_id => :integer})

    TestClass.class_eval do
      validates_format_of :name, :with => /[^!]+\z/
      has_many :test_associations
    end
    TestAssociation.class_eval do
      validates_format_of :name, :with => /[^!]+\z/
      belongs_to :test_class
    end

    @test_object = TestClass.create(:name => "Valid")
  end

  describe "Validate test classes" do
    it "TestClass should validate name format" do
      TestClass.new(name: "Invalid!").should_not be_valid
    end

    it "TestAssociation should validate name format" do
      TestAssociation.new(name: "Invalid!").should_not be_valid
    end
  end

  describe "ActiveRecord::Base#factory_spawn" do
    it "creates a new object without saving" do
      TestClass.factory_spawn.class.should == TestClass
      TestClass.factory_spawn(:name => "Test Name").name.should == "Test Name"
      TestClass.factory_spawn.id.should be_nil
    end
  end

  describe "ActiveRecord::Base#generate" do
    context "if the object is valid" do
      it "creates a new object and saves" do
        TestClass.generate(:name => "Test Name").name.should == "Test Name"
        TestClass.generate.id.should_not be_nil
      end
    end

    context "if the object is not valid" do
      it "creates a new object without saving" do
        TestClass.generate(:name => 'Invalid!').id.should be_nil
      end
    end
  end

  describe "ActiveRecord::Base#generate!" do
    context "if the object is valid" do
      it "creates a new object and saves" do
        TestClass.generate!(:name => "Test Name").name.should == "Test Name"
        TestClass.generate!.id.should_not be_nil
      end
    end

    context "if the object is not valid" do
      it "throws an error" do
        begin
          TestClass.generate!(:name => "Invalid!")
          false
        rescue ActiveRecord::RecordInvalid
          true
        end.should be_true
      end
    end
  end

  describe "ActiveRecord::Associations::AssociationProxy.factory_spawn" do
    it "creates a new object without saving" do
      @test_object.test_associations.factory_spawn.class.should == TestAssociation
      @test_object.test_associations.factory_spawn(:name => 'Test Association').name.should == 'Test Association'
      @test_object.test_associations.factory_spawn.id.should be_nil
      @test_object.test_associations.factory_spawn.test_class.should == @test_object.reload
    end
  end

  describe "ActiveRecord::Associations::AssociationProxy.generate" do
    context "if the object is valid" do
      it "creates a new object and saves" do
        @test_object.test_associations.generate.id.should_not be_nil
        @test_object.test_associations.generate.test_class.id == @test_object.id
      end
    end

    context "if the object is not valid" do
      it "creates a new object without saving" do
        @test_object.test_associations.generate(:name => "Invalid!").id.should be_nil
      end
    end
  end

  describe "ActiveRecord::Associations::AssociationProxy.generate!" do
    context "if the object is valid" do
      it "creates a new object and saves" do
        @test_object.test_associations.generate!.id.should_not be_nil
      end
    end

    context "if the object is not valid" do
      it "throws an error" do
        begin
          @test_object.test_associations.generate!(:name => "Invalid!")
          false
        rescue ActiveRecord::RecordInvalid
          true
        end.should be_true
      end
    end
  end
end
