require 'rails_helper'

feature 'User can sign up', %q{
  In order to be able to use features that requires authentication
  As non-registered User
  I want to be able to sign up
} do

  scenario 'Unregistered User tries to sign up and success' do
    visit questions_path
    click_on 'Sign up'
    fill_in 'user_email', with: 'test@email.com'
    fill_in 'user_password', with: '12345678'
    fill_in 'user_password_confirmation', with: '12345678'
    click_on 'Sign up'
    expect(page).to have_content "You have signed up successfully."
  end

  scenario 'Unregistered user tries to sign up, but passwords are not match' do
    visit questions_path
    click_on 'Sign up'
    fill_in 'user_email', with: 'my-test-email@gmail.com'
    fill_in 'user_password', with: '12345678'
    fill_in 'user_password_confirmation', with: 'password-does-not-match'
    click_on 'Sign up'
    expect(page).to have_content "Password confirmation doesn't match"
  end

  scenario 'Unregistered user tries to sign up, but email is already used' do
    visit questions_path
    click_on 'Sign up'
    fill_in 'user_email', with: create(:user).email
    fill_in 'user_password', with: '11111111'
    fill_in 'user_password_confirmation', with: '11111111'
    click_on 'Sign up'
    expect(page).to have_content "Email has already been taken"
  end
end