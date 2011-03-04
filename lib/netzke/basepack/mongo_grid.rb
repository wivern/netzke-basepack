module Netzke
  module Basepack
    class MongoGrid < Netzke::Basepack::GridPanel
      def detect_association(c)

      end

      def set_default_virtual(c)

      end

      def set_default_editable(c)

      end

      def default_fields_for_forms
        columns
      end

      def columns_default_values
        {}
      end

      def data_class_primary_key
        "id"
      end

      # Get data for the grid store
      def get_data(*args)
        {:data => get_records}
      end

      # Get records
      def get_records
        data_class.all.map do |record|
          columns.map do |c|
            record.send(c[:name])
          end
        end
      end
    end
  end
end