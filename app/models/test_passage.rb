class TestPassage < ApplicationRecord
  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_question

  scope :success, -> { where('score >= ?', SUCCESS) }

  SUCCESS = 85

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)

    save!
  end

  def percentage_score
    100.0 * correct_questions / test.questions.count
  end

  def result
    update!(score: percentage_score)
  end

  def success?
    percentage_score >= SUCCESS
  end

  def question_index
    test.questions.order(:id).where('id < ?', current_question.id).count + 1
  end

  private

  def before_validation_set_question
    if test.present? && current_question.nil?
      self.current_question = test.questions.first
    else
      self.current_question = next_question
    end
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == Array(answer_ids).map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.answer_correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

end
