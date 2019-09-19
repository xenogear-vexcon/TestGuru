class ContactsMailer < ApplicationMailer

  default to: -> { Admin.all.pluck(:email) }

  def send_message(contact_params)
    @name = contact_params[:name]
    @email = contact_params[:email]
    @message = contact_params[:message]

    mail from: @email,
         subject: "New message from #{@name}"
  end

end
