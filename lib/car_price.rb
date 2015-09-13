require 'mechanize'
require 'mongo_mapper'

Dir["#{Dir.pwd}/lib/car_price/*.rb"].each { |file| require file }

# autoload(:Car,      'car_price/car')
# autoload(:Crawler,  'car_price/crawler')
# autoload(:Category, 'car_price/category')

class CarPrice
  CATEGORIES = %w(sedan hatch convertible coupe wagon SUV Performance Prestige)

  attr_reader :host
  def initialize
    @host = 'http://www.redbook.com.au/'
  end

  def get_and_save
    get.each { |category| category.save }
  end

  def get
    CATEGORIES.map do |category|
      {
        category: category,
        cars: Crawler.new.cars(url(category))
      }
    end
  end

  private

  def url(category, year = 2015)
    if %w(Prestige Performance).include? category
      "#{host}cars/research/new?q=%28Lifestyle%3D#{category}%26YearRange%3Drange%5B#{year}..%5D%29"
    else
      "#{host}cars/research/new?q=%28BodyType%3D#{category}%26YearRange%3Drange%5B#{year}..%5D%29"
    end
  end
end

# http://www.redbook.com.au/cars/models/lifestyle/convertible?s=15&evnt=pagination
