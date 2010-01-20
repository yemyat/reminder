class ReminderController < ApplicationController
  before_filter :is_logged_in
  def create  
    @newReminder = @currentUser.reminders.new(params[:reminderform])

    if request.post?
      @newReminder.save
      unless params[:crecipient][:crecipient] == [""]
        addContact(params[:crecipient]['crecipient'],@newReminder)
      end
      unless params[:grecipient][:grecipient]==[""]
        addGroup(params[:grecipient][:grecipient],@newReminder)
      end
      if params[:reminder][:frequency] == '1'
        @newReminder.monthlies.create(:delivery_date => params[:reminderform]['reminderDate'])
      elsif params[:reminder][:frequency] =='2'
         @newReminder.yearlies.create(:delivery_date => params[:reminderform]['reminderDate'])
      elsif params[:reminder][:frequency] =='3'
         @newReminder.onetimes.create(:delivery_date => params[:reminderform]['reminderDate'])
      else
        redirect_to :action=>'create'
      end


      flash[:notice] = 'New reminder has been created'
      redirect_to :action => 'show'
    else
      flash[:notice] = 'Failed to create a reminder'
    end
  end
  
  def show
    @currentReminder = @currentUser.reminders.find(:all)

  end

  def edit
    @currentReminder = @currentUser.reminders.find_by_id(params[:id])
    if request.post?
      @currentReminder.update_attributes(params[:reminderform])
      unless params[:crecipient]['crecipient'] == [""]
        editContact(params[:crecipient]['crecipient'],@currentReminder)
      end
      unless params[:grecipient]['grecipient']==[""]
        
      end
      redirect_to :action => 'show'
    end
  end

  def delete
    @currentUser.reminders.destroy(params[:id])
  end

  def showTaggedContacts
    @taggedContacts = []
    reminderContact = Tagcontact.find(:all, :conditions=>{:profile_id => @currentUser.id,:reminder_id => params[:id]})
    reminderContact.each do |a|
      myContact = @currentUser.contacts.find_by_id(a.contact_id)
      @taggedContacts.push(myContact.firstName + ' ' + myContact.lastName)
    end
    @reminderGroup = Taggroup.find(:all, :conditions=>{:profile_id => @currentUser.id, :reminder_id => params[:id]})
    @reminderGroup.each do |b|
      @contactsInside = @currentUser.contacts.find_by_group_id(b.group_id)
      @contactsInside.each do |c|
        @taggedContacts.push(c.firstName + ' ' + c.lastName)
      end

    end
  end


  def addContact(selectedContacts,currentReminder)
    selectedContacts.each do |a|
      Tagcontact.create(:profile_id => @currentUser.id, :reminder_id => currentReminder.id,:contact_id =>a)
      taggedContact = @currentUser.contacts.find_by_id(a)
      taggedContact.update_attribute(:tagStatus, 1)
      unless taggedContact.group_id.nil?
        taggedGroup = @currentUser.groups.find_by_id(taggedContact.group_id)
        taggedGroup.update_attribute(:tagStatus,1)
      end
    end
  end

  def editContact(selectedContacts, currentReminder)
    myTagcontact = Tagcontact.find(:all, :conditions => {:reminder_id => currentReminder.id})
    myTagcontact.each do |d|
      d.update_attributes({:profile_id => @currentUser.id, :reminder_id => currentReminder.id,:group_id =>params[:reminderform]['recipient']})
      taggedContact = @currentUser.contacts.find_by_id(d.contact_id)
      taggedContact.update_attribute(:tagStatus, 1)
      unless taggedContact.group_id.nil?
        taggedGroup = @currentUser.groups.find_by_id(taggedContact.group_id)
        taggedGroup.update_attribute(:tagStatus,1)
      end
    end
  end
  def addGroup(selectedGroups,currentReminder)
    selectedGroups.each do |z|
      Taggroup.create(:profile_id => @currentUser.id, :reminder_id => currentReminder.id,:group_id =>z)
      taggedGroup = @currentUser.groups.find_by_id(z)
      taggedGroup.update_attribute(:tagStatus, 1)
      taggedContacts = @currentUser.contacts.find(:all,:conditions=>{:group_id =>z})
      taggedContacts.each do |b|
        b.update_attribute(:tagStatus, 1)
      end
    end
    
  end
end
def editGroup(selectedGroups,currentReminder)
  myTaggroup = Taggroup.find(:all, :conditions => {:reminder_id => currentReminder.id})
  myTaggroup.each do |t|
    unless t.group_id == params[:grecipient]['grecipient']
      untagGroup = @currentUser.groups.find_by_id(t.group_id)
      untagGroup.update_attribute(:tagStatus, 0)
      untagContacts = @currentUser.contacts.find(:all, :conditions=> {:group_id => untagGroup.id})
      untagContacts.each do |u|
        u.update_attribute(:tagStatus, 0)
      end
    end
    myTaggroup.save({:profile_id => @currentUser.id, :reminder_id => currentReminder.id,:group_id =>params[:grecipient]['grecipient']})
    taggedGroup = @currentUser.groups.find_by_id(t.group_ID)
    taggedGroup.update_attribute(:tagStatus, 1)
    taggedContacts = @currentUser.contacts.find(:all,:conditions=>{:group_id =>t.group_id})
    taggedContacts.each do |a|
      a.update_attribute(:tagStatus, 1)
    end
  end
end