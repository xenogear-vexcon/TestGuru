class Admin::TestsController < Admin::BaseController

  before_action :find_tests, only: %i[index update_inline]
  before_action :find_test, only: %i[show edit update destroy update_inline start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index; end

  def new
    @test = Test.new
  end

  def show; end

  def edit; end

  def create
    @test = current_user.authorship.new(test_params)
    
    if @test.save
      redirect_to admin_test_path(@test)
    else
      render 'new'
    end
  end

  def update
    if @test.update(test_params)
      redirect_to admin_test_path(@test)
    else
      render 'edit'
    end
  end

  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render 'index'
    end
  end

  def destroy
    @test.destroy
    redirect_to admin_tests_path
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id, :author_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end
  
  def find_tests
    @tests = Test.all
  end

end
