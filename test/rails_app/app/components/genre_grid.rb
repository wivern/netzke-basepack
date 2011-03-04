class GenreGrid < Netzke::Basepack::MongoGrid
  def default_config
    super.tap do |c|
      c[:model] = "Genre"
      # c[:columns] = [:id, :name]
    end
  end
end