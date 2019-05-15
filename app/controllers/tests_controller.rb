class TestsController < ApplicationController

  before_action :find_test, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    @test = Test.all
  end

  def new
    @test = Test.new
  end

  def show; end

  def edit; end

  def create
    @test = Test.new(test_params)
    if @test.save
      redirect_to @test
    else
      render 'new'
    end
  end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render 'edit'
    end
  end

  def destroy
    @test.destroy
    redirect_to tests_path
  end

  private

  def test_params
    params.require(:test).permit(:title, :level)
  end

  def find_test
    @test = Test.find(params[:id])
  end
end
