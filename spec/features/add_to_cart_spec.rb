require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'they can navigate from the home page to the product detail page by clicking on a product' do
    # ACT
    visit root_path
    first('.product .actions').click_button('Add')
    
    # DEBUG
    # save_and_open_screenshot
    # puts page.html
    
    expect(page).to have_text 'My Cart (1)'
    # save_and_open_screenshot # screenshot after second page load settles (i.e. after wait time)
  end

end
