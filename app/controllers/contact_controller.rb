class ContactController < ApplicationController
  before_filter :is_logged_in
  def show
    @currentContact = @currentUser.contacts.find(:all)
  end

  def create
    @newContact = @currentUser.contacts.new(params[:contactform])
    if request.post? 
      @newContact.save   
      flash[:notice] = 'Contact has been saved'
      redirect_to :action => 'show'
    else
      flash[:notice] = 'Contact has not yet been saved'
    end
  end

  def edit
     @currentContact = @currentUser.contacts.find_by_id(params[:id])
     if request.post?
       @currentContact.update_attributes(params[:contactform])
       redirect_to :action => 'show'
     end
  end

  def delete
     @currentContact = @currentUser.contacts.find_by_id(params[:id])
     if @currentContact.tagStatus != 1
       @currentContact.destroy
     else
       flash[:notice] = 'This user has been tagged'
     end
  end

end
