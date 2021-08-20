require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.create!(email: 'carlos@runarh.com', password: 'secret', password_confirmation: 'secret', name: 'Carlos', last_name: 'Gomez')
  end

  describe 'creation' do
    it 'can be created' do
      expect(@user).to be_valid
    end

    it 'cannot be created without name, last_name' do
      @user.name = nil
      @user.last_name = nil
      expect(@user).to_not be_valid
    end
  end
end