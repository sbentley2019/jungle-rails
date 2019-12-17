require 'rails_helper'

RSpec.feature "Visitor navigates from home page to ProductDetails page", type: :feature, js: true do

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

    scenario "They see one products details" do
      # ACT
      visit root_path      
      first_product = page.first('article.product a').click

      # VERIFY
      expect(page).to have_css 'article.product-detail'
      
      # DEBUG 
      save_screenshot
    end
end
