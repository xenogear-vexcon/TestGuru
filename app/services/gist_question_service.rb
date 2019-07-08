class GistQuestionService

  attr_reader :gist

  def initialize(question, client: default_client)
    @question = question
    @test = @question.test
    @client = client
    @gist = call
  end

  def call
    @client.create_gist(gist_params)
  end

  def success?
    gist.html_url.present?
  end

  private

  def gist_params
    {
      description: I18n.t('.description', title: @test.title),
      files: {
        'test-guru-question.txt' => {
          content: gist_content
        }
      }
    }

  end

  def gist_content
    content = [@question.body]
    content += @question.answers.pluck(:body)
    content.join("\n")
  end

  def default_client
    Octokit::Client.new(:access_token => ENV['ACCESS_TOKEN'])
  end

end