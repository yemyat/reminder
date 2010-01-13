class GroupController < ApplicationController

  before_filter :is_logged_in

  def show
    @currentGroup = @currentUser.groups.find(:all)
    
  end

  def create
      @newGroup = @currentUser.groups.new(params[:group])
      if request.post?
        @newGroup.save
        redirect_to :action=>'show'
      end
  end


  def edit
      @currentGroup = @currentUser.groups.find_by_id(params[:id])
      if request.post?
        @currentGroup.update_attributes(params[:group])
        redirect_to :action=>'show'
      else
        flash[:notice] = "Please fill in all blanks"
        redirect_to :action=> 'create'
      end
  end


  def delete
    @currentGroup = @currentUser.groups.find_by_id(params[:id])
    if @currentGroup.tagStatus != 1
      @currentGroup.destroy
    else
      flash[:notice] = 'This group has been tagged'
    end
  end




end