# require 'webmock/rspec'
require 'fakeweb'
require 'rspec'
require_relative '../lib/crawler.rb'

RSpec.describe Crawler do
  let(:url)       { 'www.redbook.com.au' }
  let(:fullurl)   { "http://#{url}" }
  let(:mock_page) { File.read("#{Dir.pwd}/spec/mock.html") }

  before do
    # stub_request(:any, url).to_return(body: mock_page, status: 200)
    FakeWeb.register_uri(:get, fullurl,
      body: mock_page, content_type: 'text/html')
  end

  describe '.new' do
    subject { described_class.new }

    # describe '#get(url)' do
    #   it 'returns a redbook page' do
    #     host = subject.get(fullurl).uri.host
    #     expect(host).to eq('www.redbook.com.au')
    #   end
    # end

    describe '#cars' do
      subject { described_class.new.cars(fullurl) }
      let(:first_car) { { brand: "Honda", model: "2015 Honda Civic Limited Edition Auto MY15", price: 24990, doors: 4, variant: "Sedan" } }
      it "returns the pages's processed cars" do
        expect(subject[0]).to eql(first_car)
      end
    end
  end
end
