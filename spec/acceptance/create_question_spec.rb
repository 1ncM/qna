require 'rails_helper'

feature 'Create question', %{
  In order to get answer from community
  As an authenticated user
  I want to be able to ask questions
} do
  
  scenario 'Authenticated user creates question' do
    sign_in create(:user)

    visit questions_path
    click_on 'Ask question'
    fill_in 'question_title', with: 'Test question'
    fill_in 'question_body', with: 'Text body'
    click_on 'Create'
    expect(page).to have_content "Test question"
    expect(page).to have_content "Text body"
  end

  scenario 'Non-Authenticated user creates question' do
    visit questions_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end