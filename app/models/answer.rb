class Answer < ApplicationRecord
  belongs_to :question

  validates :answers_quantity, on: :create

  scope :correct, -> { where(correct: true) }

  def answers_quantity
    errors.add(:question, "there 1-4 possible answers") if question.answers.count > 4
  end
end
