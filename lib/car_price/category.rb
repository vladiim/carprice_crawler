class Category
  include MongoMapper::Document

  key :category,       String
  key :model_count,    Integer
  key :brand_count,    Integer
  key :category_price, Integer
  # key :cars,           Array

  many :cars

  def self.from_hash(data)
    cars_data = remove_nil(data)
    self.new(category: data.fetch(:category),
      model_count:     model_count(cars_data),
      brand_count:     brand_count(cars_data),
      category_price:  category_price(cars_data),
      cars:            build_cars(cars_data))
  end

  private

  def self.remove_nil(data)
    data.fetch(:cars).reject { |car| car.class == NilClass }
  end

  def self.model_count(data)
    data.length
  end

  def self.brand_count(data)
    data.map { |car| car.fetch(:brand) }.uniq.size
  end

  def self.category_price(data)
    total = data.inject(0) { |sum, car| sum + car.fetch(:price) }
    total / model_count(data)
  end

  def build_cars(cars_data)

  end
end
