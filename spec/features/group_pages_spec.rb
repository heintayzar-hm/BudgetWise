require 'rails_helper'

describe '/groups', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  before do
    user.confirm # Confirm the user's email address
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_text('Signed in successfully.')
  end

  scenario 'user can create a group' do
    visit new_group_path
    expect(page).to have_text('New Category')
    fill_in 'Name', with: 'Test Group'
    attach_file 'group_icon', Rails.root.join('spec', 'fixtures', 'test_icon.png')
    click_button 'Create'

    expect(page).to have_text('Group was successfully created.')
      click_link 'Test Group'
      expect(page).to have_text('0.0') # no contracts

      click_link 'New Transaction'

    expect(page).to have_text('New Transaction')

    fill_in 'Name', with: 'Test Contract'
    fill_in 'Amount  (must be a number and in $)', with: 100

    select 'Test Group', from: 'Categories'

    click_button 'Create'

    expect(page).to have_text('Transaction created successfully.')

    expect(page).to have_text('100.0')
    click_link 'Test Group'
    click_link 'New Transaction'

    expect(page).to have_text('New Transaction')

    fill_in 'Name', with: 'Test Contract'
    fill_in 'Amount  (must be a number and in $)', with: 100

    select 'Test Group', from: 'Categories'

    click_button 'Create'

    expect(page).to have_text('Transaction created successfully.')

    expect(page).to have_text('200.0')

  end
end
