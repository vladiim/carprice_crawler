require 'mechanize'

class Crawler

  attr_reader :agent
  def initialize
    @agent = Mechanize.new
  end

  def cars(url)
    agent.get(url).
      search('.content').search('a').
      map { |car| process_car(car) }
  end

  private

  def get(url)
    agent.get(url)
  end

  def process_car(raw_car)
    return if not_car(raw_car)
    {
      brand: car_brand(raw_car),
      model: car_model(raw_car),
      price: car_price(raw_car),
      doors: car_doors(raw_car),
      variant: car_variant(raw_car)
    }
  end

  def not_car(raw_car)
    car_summary(raw_car).class == NilClass
  end

  def car_brand(raw_car)
    car_model(raw_car).match(/(\d{4}\s)(\w+)/)[2]
  end

  def car_model(raw_car)
    raw_car.search('.desc').search('h3').text
  end

  def car_price(raw_car)
    raw_car.search('.price').text.gsub('$', '').gsub(',', '').gsub('*','').to_i
  end

  def car_summary(raw_car)
    raw_car.search('ul.summary').search('li')[0]
  end

  def car_doors(raw_car)
    car_summary(raw_car).text.split(',')[1].match(/\d/)[0].to_i
  end

  def car_variant(raw_car)
    car_summary(raw_car).text.split(',')[0]
  end
end
