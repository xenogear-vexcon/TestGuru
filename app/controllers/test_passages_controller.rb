class TestPassagesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_test_passage, only: %i[show update result gist]

  def show; end

  def result; end
  
  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      get_badges(@test_passage)
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    result = GistQuestionService.new(@test_passage.current_question)
    link = "<a href=\"#{url_for(result.url)}\">gist</a>"

    if result.success?
      Gist.create!(url: result.url, user: @test_passage.user, question: @test_passage.current_question)
      flash[:notice] = t('.success', link: link)
    else
      flash[:alert] = t('.failure')
    end

    redirect_to @test_passage
  end

  def get_badges(test_passage)
    badges = BadgeService.new(test_passage).call

    unless badges.empty?
      current_user.badges << badges
      flash[:notice] = t('badge.success')
    end
  end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

end
