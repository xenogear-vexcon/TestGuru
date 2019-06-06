class TestPassage < ApplicationRecord
  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create

  SUCCESS = 85

  def complited?
    current_question.nil?
  end

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_answers += 1
      save!
    end

    self.current_question = next_question
    save!
  end

  def percentage_score
    (100.0 * correct_answers.count / test.questions.count)
  end

  def test_passed?
    percentage_score >= SUCCESS
  end

  def question_index
    test.questions.order(:id).where('id < ?', current_question.id).count + 1
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    (correct_answers.count == correct_answers.where(id: answer_ids).count) &&
    (correct_answers.count == answer_ids.count)
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

end
