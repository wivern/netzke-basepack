module Netzke
  module Mongoid
    # Methods that we are missing (or need to reimplement) in Mongoid::Document
    module Adaptor
      extend ActiveSupport::Concern

      module ClassMethods

        # HACK. This behavior was promised by Mongoid
        def find(*args)
          if args.first.is_a?(String) && args.count == 1
            super(BSON::ObjectId(args.first))
          else
            super
          end
        end

        # def destroy(*args)
        #   if args.first.is_a?(Array)
        #     super(args.first.map{ |el| BSON::ObjectId(el) })
        #   else
        #     super
        #   end
        # end

        def model_name
          res = self.name
          def res.human
            self
          end
          def res.i18n_key
            self
          end
          res
        end

        def column_names
          ["id", *fields.keys] - ["_type", "_id"]
        end

        def columns_hash
          fields.keys.inject({}) do |r,k|
            f = fields[k]
            r.merge(k => Netzke::Core::OptionsHash.new.merge(:name => f.name, :type => f.type.name.underscore.to_sym))
          end.merge("id" => Netzke::Core::OptionsHash.new.merge(:name => "id", :type => :string))
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
