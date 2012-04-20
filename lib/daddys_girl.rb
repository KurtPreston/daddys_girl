require 'active_record'

ActiveRecord::Base.class_eval do
  class << self
    def symbol
      self.name.underscore.to_sym
    end

    def generate(attributes = {})
      begin
        FactoryGirl.create(self.symbol, attributes)
      rescue ActiveRecord::RecordInvalid
        FactoryGirl.build(self.symbol, attributes)
      end
    end

    def generate!(attributes = {})
      FactoryGirl.create(self.symbol, attributes)
    end

    def spawn(attributes = {})
      FactoryGirl.build(self.symbol, attributes)
    end
  end
end

if ActiveRecord::VERSION::MAJOR == 3 && ActiveRecord::VERSION::MINOR == 0
  ActiveRecord::Associations::AssociationProxy.class_eval do
    def target_class_symbol
      self.symbol
    end

    def generate(attributes = {})
      attributes = attributes.merge(association_attribute)
      begin
        FactoryGirl.create(target_class_symbol, attributes)
      rescue ActiveRecord::RecordInvalid
        FactoryGirl.build(target_class_symbol, attributes)
      end
    end

    def generate!(attributes = {})
      attributes = attributes.merge(association_attribute)
      FactoryGirl.create(target_class_symbol, attributes)
    end

    def spawn(attributes = {})
      attributes = attributes.merge(association_attribute)
      FactoryGirl.build(target_class_symbol, attributes)
    end

    private
    def owner_association
      proxy_reflection.primary_key_name.to_sym
    end

    def association_attribute
      {owner_association => proxy_owner.id}
    end
  end
end


if ActiveRecord::VERSION::MAJOR == 3 && ActiveRecord::VERSION::MINOR >= 1
  ActiveRecord::Relation.class_eval do
    def target_class_symbol
      self.symbol
    end

    def generate(attributes = {})
      attributes = attributes.merge(where_values_hash)
      begin
        FactoryGirl.create(target_class_symbol, attributes)
      rescue ActiveRecord::RecordInvalid
        FactoryGirl.build(target_class_symbol, attributes)
      end
    end

    def generate!(attributes = {})
      attributes = attributes.merge(where_values_hash)
      FactoryGirl.create(target_class_symbol, attributes)
    end

    def spawn(attributes = {})
      attributes = attributes.merge(where_values_hash)
      FactoryGirl.build(target_class_symbol, attributes)
    end

  end
end
