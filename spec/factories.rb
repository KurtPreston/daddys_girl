FactoryGirl.define do
  factory :test_class do
    name 'Test Name'
  end
end

class TestClass < ActiveRecord::Base
  def self.columns() @columns ||= []; end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end

  column :name, :string
end
