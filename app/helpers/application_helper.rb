module ApplicationHelper

  def current_date
    Date.current
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}" 
  end

end
