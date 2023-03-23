require 'rails_helper'

describe '/', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario 'after login user page should be categories, after logout it should be splash' do
    user.confirm # Confirm the user's email address
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')

    expect(page).to have_text('Categories')

    click_button 'Log out'
    expect(page).to have_text('Log In')
  end

  scenario 'at the start it is splash' do
    visit root_path
    expect(page).to have_text('Log In')
  end
end
