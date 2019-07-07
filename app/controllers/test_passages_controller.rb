class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[show update result gist]

  def show; end

  def result; end
  
  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      TestMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    result = GistQuestionService.new(@test_passage.current_question).call

    flash_options = if result.success?
      create_gist!(gist_url)
      { notice: t('.success', url: gist_url.html_url) }
    else
      { alert: t('.failure') }
    end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def create_gist!(gist_url)
    current_user.gists.create(user: @test_passage.user, question: @test_passage.current_question, url: gist_url.html_url)
  end

end
