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

      it 'redirect_to question view' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to question
      end

      it 'associates new answer with current user' do
        post :create, params: { answer: attributes_for(:answer), question_id: question }
        expect(assigns(:answer).user).to eq subject.current_user
      end
    end

    context 'with invalid answer' do
      it 'not save in database' do
        expect { post :create, params: { answer: attributes_for(:invalid_answer), question_id: question }}.to_not change(question.answers,:count)        
      end

      it 'render question' do
        post :create, params: { answer: attributes_for(:invalid_answer), question_id: question}        
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user
    before do
      @question = create(:question, user: @user)
      @answer = create(:answer, question: @question, user: @user)
    end

    context 'author of answer' do
      it 'deletes the answer' do
        expect { delete :destroy, params: { id: @answer, question_id: @question}}.to change(Answer, :count).by(-1)
      end

      it 'redirect to question path' do
        delete :destroy, params: { id: @answer, question_id: @question }
        expect(response).to redirect_to @question
      end
    end

    context 'not an author of question' do
      before do
        sign_out(@user)
        sign_in(create(:user))
      end

      it 'does not delete answer' do
        expect { delete :destroy, params: { id: @answer, question_id: @question }}.to_not change(Answer, :count)
      end

      it 'redirect to question path' do
        delete :destroy, params: { id: @answer, question_id: @question }
        expect(response).to redirect_to @question
      end
    end
  end
end
