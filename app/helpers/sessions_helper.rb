module SessionsHelper
  def flash_message(key, message)
    content_tag :p, message, class: "flash #{key}"
  end
end
