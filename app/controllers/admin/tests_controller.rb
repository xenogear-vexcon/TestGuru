class Admin::TestsController < Admin::BaseController

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
    @test.author = current_user
    
    if @test.save
      flash[:success] = "Test was successfully created."
      redirect_to [:admin, @test]
    else
      render 'new'
    end
  end

  def update
    if @test.update(test_params)
      flash[:success] = "Test was successfully updated."
      redirect_to [:admin, @test]
    else
      render 'edit'
    end
  end

  def destroy
    @test.destroy
    flash[:danger] = "Test was successfully deleted."
    redirect_to admin_tests_path
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

end
