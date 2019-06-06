module TestPassagesHelper
  def result_message(scores)
    if @test_passage.test_passed?
      content_tag(:p, "Test passed with #{scores}% result. Well done!", class: "test_success")
    else
      content_tag(:p, "Test failed with #{scores}% result. Try one more time!", class: "test_fail")
    end
  end
end
