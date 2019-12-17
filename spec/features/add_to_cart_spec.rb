require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "Add 1 product to the cart" do
    # ACT
    visit root_path

    product1 = page.first('article.product')
    product1.find_button('Add').click

    expect(page.find_link(href:'/cart')).to have_text 'My Cart (1)'

    # DEBUG 
    save_screenshot
  end
end
