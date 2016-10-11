require 'rails_helper'

feature 'Write answer for question', %{
  In order to help solve the problem
  As an authenticated user
  I want to be able to write answer for question
} do

  given(:question) { create(:question) }

  scenario 'Authenticated user write answer for question', js: true do
    sign_in create(:user)
    visit question_path(question)
    fill_in 'answer_body', with: 'Text text'
    click_on 'Post Your Answer'
    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content('Text text')
    end
  end

  scenario 'Authenticated user submit empty answer for the question', js: true do
    sign_in create(:user)
    visit question_path(question)
    fill_in 'answer_body', with: ''
    click_on 'Post Your Answer'
    expect(current_path).to eq question_path(question)
    expect(question.answers.count).to eq 0
  end

  scenario 'Non-authenticated user can not create answer on the question' do
    visit question_path(question)
    expect(page).to_not have_link 'Post Your Answer'
  end

end