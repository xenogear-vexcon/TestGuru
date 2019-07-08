module GistsHelper
  def gist_url(url)
    url.split('/').last
  end
end
