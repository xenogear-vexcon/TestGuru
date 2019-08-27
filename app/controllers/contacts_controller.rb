class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new(params[:contact])
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    
    if @contact.deliver
      flash.now[:notice] = t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new
    end
  end
end
