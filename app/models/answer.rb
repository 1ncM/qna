class Answer < ApplicationRecord
  belongs_to :question, class_name: 'Question', foreign_key: :question_id

  validates :owner, :email, :body, presence: true
end
