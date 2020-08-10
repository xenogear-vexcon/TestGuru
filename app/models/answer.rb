class Answer < ApplicationRecord
  belongs_to :question

  validate :answers_quantity, on: :create

  scope :answer_correct, -> { where(correct: true) }

  def answers_quantity
    errors.add(:question, "there 1-4 possible answers") if question.answers.count >= 4
  end
end
