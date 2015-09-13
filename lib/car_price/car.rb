class Car
  attr_reader :raw_data
  def initialize(raw_data)
    @raw_data = raw_data
  end

  def data
    {
      brand:  brand,
      model:  model,
      price:  price,
      doors:  doors,
      variant: variant
    }
  end

  def not_car
    summary.class == NilClass
  end

  private

  def brand
    model.match(/(\d{4}\s)(\w+)/)[2]
  end

  def model
    raw_data.search('.desc').search('h3').text
  end

  def price
    raw_data.search('.price').text.gsub('$', '').gsub(',', '').gsub('*','').to_i
  end

  def summary
    raw_data.search('ul.summary').search('li')[0]
  end

  def doors
    summary.text.split(',')[1].match(/\d/)[0].to_i
  end

  def variant
    summary.text.split(',')[0]
  end
end
