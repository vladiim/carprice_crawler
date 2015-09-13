require_relative 'spec_helper.rb'

RSpec.describe Category do
  let(:data) do
    {
      category: "CATEGORY",
      cars:
        [ {brand: "Honda", price: 1},
          {brand: "Mazda", price: 3}, nil]
    }
  end

  describe '.from_hash' do
    subject { described_class.from_hash(data) }

    it 'removes nil objects' do
      expect(subject.class).to eql(Category)
    end

    it 'calculates the model count' do
      expect(subject.model_count).to eq(2)
    end

    it 'calculates the brand count' do
      expect(subject.brand_count).to eq(2)
    end

    it 'calculates the average price' do
      expect(subject.category_price).to eq(2)
    end
  end
end
