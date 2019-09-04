class ContactsMailer < ApplicationMailer

  default to: -> { Admin.all.pluck(:email) }

  def send_message(message, user)
    @user = user
    @message = message

    mail from: @user.email,
         subject: "New message from #{@user.name}"
  end

end
