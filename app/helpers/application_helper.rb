module ApplicationHelper
  def current_date
    Date.today
  end
  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}" 
  end
end
