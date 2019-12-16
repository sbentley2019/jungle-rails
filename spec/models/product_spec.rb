require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.find_or_create_by! name: 'Fruit'
    end

    it 'is valid with valid attributes' do
      product = Product.new(name: "lemons", price_cents: 100, quantity: 10, category: @category)
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product = Product.new(name: nil, price_cents: 100, quantity: 10, category: @category)
      expect(product).to_not be_valid
    end

    it 'is not valid without a price' do
      product = Product.new(name: "lemons", price_cents: nil, quantity: 10, category: @category)
      expect(product).to_not be_valid
    end

    it 'is not valid without a quantity' do
      product = Product.new(name: "lemons", price_cents: 100, quantity: nil, category: @category)
      expect(product).to_not be_valid
    end

    it 'is not valid without a category' do
      product = Product.new(name: "lemons", price_cents: 100, quantity: 10, category: nil)
      expect(product).to_not be_valid
    end
  end
end