class Genre
  include Mongoid::Document
  # self.primary_key = '_id'
  key :id
  field :name#, :type => String
  field :rating, :type => Integer
end