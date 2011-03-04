module Netzke
  module Mongoid
    # Methods that we are missing (or need to reimplement) in Mongoid::Document
    module Adaptor
      extend ActiveSupport::Concern

      module ClassMethods
        def column_names
          ["id", *fields.keys]
        end

        def columns_hash
          fields.keys.inject({}) do |r,k|
            f = fields[k]
            r.merge(k => Netzke::Core::OptionsHash.new.merge(:name => f.name, :type => f.type.name.underscore.to_sym))
          end.merge("id" => Netzke::Core::OptionsHash.new.merge(:name => "id", :type => :integer))
        end

        def destroy(*ids)
          ids.each do |id|
            Genre.find(id).first.destroy
          end
        end
      end
    end
  end
end