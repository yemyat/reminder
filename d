[33mcommit ee8eaae57722babb30c6fd08beac889e5ec71ae0[m
Author: Ye Myat Min <yemyat@gmail.com>
Date:   Wed Jan 20 08:15:31 2010 +0800

    init

[1mdiff --git a/app/controllers/application_controller.rb b/app/controllers/application_controller.rb[m
[1mindex f485573..80b2519 100644[m
[1m--- a/app/controllers/application_controller.rb[m
[1m+++ b/app/controllers/application_controller.rb[m
[36m@@ -3,7 +3,6 @@[m
 [m
 class ApplicationController < ActionController::Base[m
   helper :all # include all helpers, all the time[m
[31m-  helper ExtJS::Helpers::Component[m
   protect_from_forgery # See ActionController::RequestForgeryProtection for details[m
 [m
   # Scrub sensitive parameters from your log[m
[1mdiff --git a/app/controllers/category_controller.rb b/app/controllers/category_controller.rb[m
[1mindex 3007c35..0381b81 100644[m
[1m--- a/app/controllers/category_controller.rb[m
[1m+++ b/app/controllers/category_controller.rb[m
[36m@@ -1,14 +1,22 @@[m
 class CategoryController < ApplicationController[m
[32m+[m[32m  before_filter :is_logged_in[m
   def create[m
[31m-      @newCategory = Category.new(params[:categoryform])[m
[32m+[m[32m      @newCategory = @currentUser.categories.new(params[:categoryform])[m
       if request.post?[m
         @newCategory.save[m
[32m+[m[41m      [m
       end[m
   end[m
 [m
   def delete[m
[31m-     @currentCategory = Category.find_by_id(params[:id])[m
[32m+[m[32m     @currentCategory = @currentUser.categories.find_by_id(params[:id])[m
      @currentCategory.destroy[m
   end[m
[32m+[m[32m  def edit[m
 [m
[32m+[m[32m  end[m
[32m+[m[32m  def show[m
[32m+[m[41m    [m
[32m+[m[32m  end[m
 end[m
[32m+[m[41m [m
\ No newline at end of file[m
[1mdiff --git a/app/controllers/profile_controller.rb b/app/controllers/profile_controller.rb[m
[1mindex d482ccc..8ba4e2e 100644[m
[1m--- a/app/controllers/profile_controller.rb[m
[1m+++ b/app/controllers/profile_controller.rb[m
[36m@@ -35,9 +35,10 @@ class ProfileController < ApplicationController[m
     @encryptPassword = Digest::SHA1.hexdigest(@newUser.password)[m
     @registerUser = Profile.create(:password => @encryptPassword, :firstName => @newUser.firstName, :lastName => @newUser.lastName, :mobilePhone => @newUser.mobilePhone, :email =>@newUser.email, :gender => @newUser.gender,:dateOfBirth =>@newUser.dateOfBirth, :membership =>@newUser.membership  )[m
     if @registerUser.save[m
[31m-      render :text=> "Registration successful"[m
[32m+[m
[32m+[m[32m      redirect_to :action => 'login'[m
     else[m
[31m-      render :text => 'Registration failed'[m
[32m+[m[32m      redirect_to :action => 'register'[m
     end[m
     [m
   end[m
[1mdiff --git a/app/controllers/reminder_controller.rb b/app/controllers/reminder_controller.rb[m
[1mindex a7fda67..517ce5e 100644[m
[1m--- a/app/controllers/reminder_controller.rb[m
[1m+++ b/app/controllers/reminder_controller.rb[m
[36m@@ -1,15 +1,27 @@[m
 class ReminderController < ApplicationController[m
   before_filter :is_logged_in[m
[31m-  def create[m
[32m+[m[32m  def create[m[41m  [m
     @newReminder = @currentUser.reminders.new(params[:reminderform])[m
[32m+[m
     if request.post?[m
[31m-      @newReminder.save(:reminderTitle => @newReminder.reminderTitle,:reminderMessage => @newReminder.reminderMessage, :reminderDate => @newReminder.reminderDate)[m
[32m+[m[32m      @newReminder.save[m
       unless params[:crecipient][:crecipient] == [""][m
         addContact(params[:crecipient]['crecipient'],@newReminder)[m
       end[m
       unless params[:grecipient][:grecipient]==[""][m
         addGroup(params[:grecipient][:grecipient],@newReminder)[m
       end[m
[32m+[m[32m      if params[:reminder][:frequency] == '1'[m
[32m+[m[32m        @newReminder.monthlies.create(:delivery_date => params[:reminderform]['reminderDate'])[m
[32m+[m[32m      elsif params[:reminder][:frequency] =='2'[m
[32m+[m[32m         @newReminder.yearlies.create(:delivery_date => params[:reminderform]['reminderDate'])[m
[32m+[m[32m      elsif params[:reminder][:frequency] =='3'[m
[32m+[m[32m         @newReminder.onetimes.create(:delivery_date => params[:reminderform]['reminderDate'])[m
[32m+[m[32m      else[m
[32m+[m[32m        redirect_to :action=>'create'[m
[32m+[m[32m      end[m
[32m+[m
[32m+[m
       flash[:notice] = 'New reminder has been created'[m
       redirect_to :action => 'show'[m
     else[m
[36m@@ -19,13 +31,13 @@ class ReminderController < ApplicationController[m
   [m
   def show[m
     @currentReminder = @currentUser.reminders.find(:all)[m
[32m+[m
   end[m
 [m
   def edit[m
     @currentReminder = @currentUser.reminders.find_by_id(params[:id])[m
     if request.post?[m
       @currentReminder.update_attributes(params[:reminderform])[m
[31m-       [m
       unless params[:crecipient]['crecipient'] == [""][m
         editContact(params[:crecipient]['crecipient'],@currentReminder)[m
       end[m
[36m@@ -41,17 +53,24 @@ class Remind