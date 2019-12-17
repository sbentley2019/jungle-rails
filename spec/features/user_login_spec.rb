require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create(firstname:"john", lastname:"doe", email:"john@email.com", password:"1234", password_confirmation:"1234")
  end

  scenario "A user logs in successfully" do
    # ACT
    visit '/login'

    form = page.find('form')
    form.fill_in 'email', with: 'john@email.com'
    form.fill_in 'password', with: '1234'
    form.find('input[name="commit"]').click

    # VERIFY
    expect(page.find('ul.navbar-right')).to have_text 'Logout'

    # DEBUG 
    save_screenshot
  end
end
