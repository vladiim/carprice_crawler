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

  def process_car(raw_data)
    car = CarScrapper.new(raw_data)
    return if car.not_car
    car.data
  end
end
