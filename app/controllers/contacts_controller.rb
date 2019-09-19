class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    
    if @contact.valid?
      ContactsMailer.send_message(contact_params).deliver_now
      flash.now[:notice] = t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
