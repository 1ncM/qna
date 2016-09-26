require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question)}
  let(:answer) { create(:answer) }

  describe 'POST #create' do
    sign_in_user
    let(:question) { create(:question)}
    
    context 'with valid answer' do
      it 'save answer in database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question }}.to change { question.answers.count }.by(1)
      end

      it 'redirect_to @question' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid answer' do
      it 'not save in database' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question }}.to_not change(question.answers,:count)        
      end

      it 'render new view' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question}        
        expect(response).to render_template :new
      end
    end
  end
end
