module ApplicationHelper

  def current_date
    Date.current
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}" 
  end

  def flashes_bootstrap(flash_type)

    case flash_type
      when 'success'
        'alert-success'
      when 'error'
        'alert-danger'
      when 'alert'
        'alert-warning'
    else
      flash_type.to_s
    end
  end

end
