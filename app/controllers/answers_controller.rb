class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :find_answer, only: [:destroy]
  before_action :must_be_author!, only: [:destroy]

  def create
    @question = Question.find(params[:question_id])  
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    if @answer.save
      redirect_to @question
    else
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@answer.question)
  end

  private

  def must_be_author!
    unless current_user.author_of?(@answer)
      redirect_to @answer.question, error: "You can delete only your answer"
    end
  end

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
