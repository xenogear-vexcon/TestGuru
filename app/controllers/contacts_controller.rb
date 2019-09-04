class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.author = current_user
    
    if @contact.save
      ContactsMailer.send_message(@contact, current_user).deliver_now
      flash.now[:notice] = t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:message)
  end
end
