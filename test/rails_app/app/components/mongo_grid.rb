# Grid component that works with Mongoid
# Configuration:
# * model (required) - Mongo document model name, e.g. "Genre"
# * columns (required) - an array of column names, e.g. [:name, :rating]
class MongoGrid < Netzke::Base
  js_base_class "Ext.grid.EditorGridPanel"
  js_mixin :mongo_grid

  # Do all the internal initializations
  def initialize(*args)
    super
    @data_class = config[:model].constantize
  end

  def default_config
    super.merge(
      # These options are expected in the config
      :model => "Genre",
      :columns => [:id, :name]
    )
  end

  def js_config
    super.tap do |s|
      s[:columns] = columns
      s[:inline_data] = get_data
    end
  end

  protected
    # Normalized columns
    def columns
      config[:columns].map do |c|
        c.is_a?(Hash) ? c : {
          :name => c.to_s,
          :header => c.to_s.humanize
        }
      end
    end

    # Get data for the grid store
    def get_data
      {:data => get_records}
    end

    # Get records
    def get_records
      @data_class.all.map do |record|
        columns.map do |c|
          record.send(c[:name])
        end
      end
    end
end