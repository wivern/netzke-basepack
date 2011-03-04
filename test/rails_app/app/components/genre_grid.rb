class GenreGrid < Netzke::Basepack::MongoGrid
  def default_config
    super.tap do |c|
      c[:model] = "Genre"
      # c[:columns] = [{:name => :id, :width => 150}, {:name => :name}]
    end
  end
end