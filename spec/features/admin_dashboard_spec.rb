require 'rails_helper'

describe 'admin_dashboard' do
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

  # Users can't be reach admin dashboard without first: be loged in and second: be an admin
  it 'does not allow users to access without being signed in' do
    visit admin_root_path
    expect(page.current_path).to eq(new_user_session_path)
  end

  it 'cannot be reached by a non admin users' do
    login_as(@user, scope: :user)
    visit admin_root_path
    expect(current_path).to eq(root_path)
  end

  it 'can be reached by an admin users' do
    login_as(@admin, scope: :user)
    visit admin_root_path
    expect(current_path).to eq(admin_root_path)
  end
end