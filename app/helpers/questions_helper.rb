module QuestionsHelper
  def question_header(question)
    action = question.new_record? ? 'Create' : 'Edit'
    "#{action} *#{question.test.title}* Question"
  end
end
