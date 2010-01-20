class ProfileController < ApplicationController
  def authenticate
    @user = Profile.new(params[:userform])
    @encryptPassword= Digest::SHA1.hexdigest(@user.password)
    auth_user = Profile.find_by_email_and_password(@user.email,@encryptPassword)
    if auth_user
      session[:profile_id] = auth_user.id
      redirect_to '/reminder/create'
    else
      render :text => "Invalid username or password"
    end
    
  end
  def login

    @page_title = "Login"
  end

  def logout
    @page_title = "Logout"
    if session[:profile_id]
      flash[:notice] = "Successfully logged out"
      reset_session
    else
      redirect_to :action => 'login'
    end
  end

  def register  
    @page_title = "Register"
  end

  def doregister
    @newUser = Profile.new(params[:userform])
    @encryptPassword = Digest::SHA1.hexdigest(@newUser.password)
    @registerUser = Profile.create(:password => @encryptPassword, :firstName => @newUser.firstName, :lastName => @newUser.lastName, :mobilePhone => @newUser.mobilePhone, :email =>@newUser.email, :gender => @newUser.gender,:dateOfBirth =>@newUser.dateOfBirth, :membership =>@newUser.membership  )
    if @registerUser.save

      redirect_to :action => 'login'
    else
      redirect_to :action => 'register'
    end
    
  end

end
