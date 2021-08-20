require 'rails_helper'

describe 'navigate' do

  # Create a new regular user and associate a job day 
  # TODO: Refactor users using FactoryGirl
  before do
    @user = User.create!(email: 'carlos@runarh.com', password: 'secret', password_confirmation: 'secret', name: 'Carlos', last_name: 'Gomez')

    login_as(@user, scope: :user)

    @day = WorkingDay.create!(checkin: '2020-02-11 05:15:00', checkout: '2020-02-11 14:00:00', user_id: @user.id)
  end

  # Test if working day index can be reached, has title and displays correct data
  describe 'index' do
    it 'can be reached successfully' do
      visit working_days_path
      expect(page.status_code).to eq(200)
    end

    it 'has a title' do
      visit working_days_path
      expect(page).to have_content(/History of the workday/)
    end

    it 'must present days data for regular user' do
      visit working_days_path
      # Formatted data from helpers
      expect(page).to have_content(/February - 11 - 20/)
      expect(page).to have_content(/05 : 15, AM/)
      expect(page).to have_content(/14 : 00, PM/)
    end
  end

  # New page must be reached and must be presenting correct data
  describe 'new' do
    it 'can be reached successfully' do
      visit new_working_day_path
      expect(page.status_code).to eq(200)
    end

    it 'has a title' do
      visit new_working_day_path
      expect(page).to have_content(/Register your time job/)
    end
  end
end