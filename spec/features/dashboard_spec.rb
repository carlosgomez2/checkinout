require 'rails_helper'

describe 'navigate' do
  
  # TODO: Refactor users using FactoryGirl
  before do
    @user = User.create!(
      name: 'carlos', 
      last_name: 'gomez', 
      email: 'test@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
    @admin = AdminUser.create!(
      name: 'sofia', 
      last_name: 'gomez', 
      email: 'admin@test.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  # Dashboard must be presenting orrect data and must be reached for users
  describe 'index' do
    it 'can be reached successfully' do
      visit root_path
      expect(page.status_code).to eq(200)
    end

    it 'should be display correct data for regular user' do
      login_as(@user, scope: :user)
      visit root_path
      expect(page).to have_content(/Welcome Carlos!/)
      expect(page).to have_content(/Checkin/)
      expect(page).to have_content(/Checkout/)
      expect(page).to have_selector(:link_or_button, 'Save')
    end

    it 'should be display correct data for admin user' do
      login_as(@admin, scope: :user)
      visit root_path
      expect(page).to have_content(/Welcome Sofia!/)
      expect(page).to have_selector(:link_or_button, 'Search')
    end
  end
end