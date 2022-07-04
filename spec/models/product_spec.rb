require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should save if all fields are valid' do
      category = Category.new
      product = Product.new(name: 'apple tree', price: 4, quantity: 4, category: category)
      product.save
      expect(product).to be_valid
    end

    it 'should not save without a valid name' do
      category = Category.new
      product = Product.new(name: nil, price: 4,quantity: 4, category: category)
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save without a valid price' do
      category = Category.new
      product = Product.new(name: 'apple tree', price: false, quantity: 4, category: category)
      product.save
      expect(product.errors.full_messages).to include("Price cents is not a number")
    end

    it 'should not save without a valid quantity' do
      category = Category.new
      product = Product.new(name: 'apple tree', price: 4, quantity: nil, category: category)
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save without a valid category' do
      category = Category.new
      product = Product.new(name: 'apple tree', price: 4, quantity: 4, category: nil)
      product.save
      expect(product.errors.full_messages).to include("Category must exist")
    end

  end
end
