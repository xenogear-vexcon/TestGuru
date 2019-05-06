class Answer < ApplicationRecord
  belongs_to :question

  validates :answers_quantity, on: :create

  scope :cor_answers, -> { where(correct: true) }

  def answers_quantity
    errors.add(:question, "there 1-4 possible answers") if question.answers.quantity.exclude?(1..4)
  end
end
