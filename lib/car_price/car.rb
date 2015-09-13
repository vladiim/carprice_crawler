class Car
  include MongoMapper::EmbeddedDocument

  key :brand,   String
  key :model,   String
  key :variant, String
  key :doors,   Integer
  key :price,   Integer
end
