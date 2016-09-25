require 'rails_helper'

feature 'View question and answers', %q{
  In order to view the whole question and existing answers to it
  As any user
  I want to be able to see the question details view with answers
} do

  given(:question) {create(:question)}
  scenario 'Any user can see question view with list of answers' do
    answer1, answer2 = create_list(:answer, 2, question: question)
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content answer1.body
    expect(page).to have_content answer2.body
  end
end