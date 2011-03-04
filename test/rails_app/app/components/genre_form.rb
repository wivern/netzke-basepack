class GenreForm < Netzke::Basepack::FormPanel
  def default_config
    super.merge(:model => "Genre", :record => Genre.first)
  end

  def data_class_primary_key
    "id"
  end
end