require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(:name => 'Example Category')
      
    end

    it 'ensures a product with all four fields set will save successfully' do
      @product = @category.products.create({
        name:  'Example Product Name',
        description: 'Example Product Description',
        quantity: 99,
        price: 19.97
      })
      expect(@product.save).to be_truthy
    end

    it 'validates :name, presence: true' do
      product = Product.create({
        category_id: @category.id,
        name:  nil,
        description: 'Example Product Description',
        quantity: 99,
        price: 19.97
      })
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates :price, presence: true' do
      product = Product.create({
        category_id: @category.id,
        name:  'Example Product Name',
        description: 'Example Product Description',
        quantity: 99,
        price: nil
      })
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
  
    it 'validates :quantity, presence: true' do
      product = Product.create({
        category_id: @category.id,
        name:  'Example Product Name',
        description: 'Example Product Description',
        quantity: nil,
        price: 19.97
      })
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'validates :category, presence: true' do
      product = Product.create({
        category_id: nil,
        name:  'Example Product Name',
        description: 'Example Product Description',
        quantity: 99,
        price: 19.97
      })
      expect(product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
