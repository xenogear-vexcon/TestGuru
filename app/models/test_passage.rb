class TestPassage < ApplicationRecord
  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_question

  SUCCESS = 85

  def completed?
    current_question.nil?
  end

  def accept!(answer_ids)
    self.correct_answers += 1 if correct_answer?(answer_ids)

    save!
  end

  def percentage_score
    100.0 * correct_answers.count / test.questions.count
  end

  def test_passed?
    percentage_score >= SUCCESS
  end

  def question_index
    test.questions.order(:id).where('id < ?', current_question.id).count + 1
  end

  def correct_answers
    current_question.answers.correct
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

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

end