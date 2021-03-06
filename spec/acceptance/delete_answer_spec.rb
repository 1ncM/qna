require 'rails_helper'

feature 'Delete answer', %q{
  In order to don't be ashamed for your answer
  As as author of answer
  I want to be able to delete my answer
} do

  let!(:user) { create(:user) }
  before(:each) do
    sign_in(user)
    @question = create(:question, user: user)
    @answer = create(:answer, question: @question, user: user)
  end

  scenario 'Author of answer delete answer on his question' do
    visit question_path(@question)
    click_on 'Delete answer'
    expect(page).to have_current_path(question_path(@question))
    expect(page).to_not have_content(@answer.body)
  end

  scenario 'Non-author can not delete answer' do
    sign_out
    sign_in(create(:user))
    visit question_path(@question)
    expect(page).to_not have_link 'Delete Answer'
  end

  scenario 'Non-authenticated user can not delete answer' do
    sign_out
    visit question_path(@question)

    within('.answers') do
      expect(page).to have_no_link("Delete Answer", href: answer_path(@answer))
    end
  end
end