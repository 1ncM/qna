class Answer < ApplicationRecord
  validates :owner, :email, presence: true
end
