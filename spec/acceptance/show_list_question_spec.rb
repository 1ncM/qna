require 'rails_helper'

feature 'Show list questions', %{
  In order to find the question
  As an authenticated user
  I want to be able to view a list of questions
} do

  given(:user) { create(:user) }

  scenario 'Authenticated user view list questions' do
    q1, q2 = create_list(:question, 2)
    sign_in(user)
    visit questions_path
    expect(page).to have_content q1.title
    expect(page).to have_content q2.title
  end

end