module DaddysGirl
  module ActiveRecordModel
    class << self
      def symbol
        self.name.underscore.to_sym
      end

      def generate(attributes = {})
        FactoryGirl.create(self.symbol, attributes)
      end

      def generate!(attributes = {})
        FactoryGirl.create(self.symbol, attributes).tap do |obj|
          raise obj.errors.inspect unless obj.errors.empty?
        end
      end

      def spawn(attributes = {})
        FactoryGirl.build(self.symbol, attributes)
      end
    end
  end
end

ActiveRecord::Base.send(:include, DaddysGirl::ActiveRecordModel) if defined?(ActiveRecord)


module DaddysGirl
  module AssociationModel
    def target_class_symbol
      self.symbol
    end

    def generate(attributes = {})
      attributes = attributes.merge(association_attribute)
      FactoryGirl.create(target_class_symbol, attributes)
    end

    def generate!(attributes = {})
      attributes = attributes.merge(association_attribute)
      FactoryGirl.create(target_class_symbol, attributes).tap do |obj|
        raise obj.errors.inspect unless obj.errors.empty?
      end
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

ActiveRecord::Associations::AssociationProxy.send(:include, DaddysGirl::AssociationModel) if defined?(ActiveRecord)
