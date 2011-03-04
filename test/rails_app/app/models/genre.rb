class Genre
  include Mongoid::Document
  field :name#, :type => String
  field :rating, :type => Integer
end