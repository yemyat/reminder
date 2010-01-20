class CategoryController < ApplicationController
  before_filter :is_logged_in
  def create
      @newCategory = @currentUser.categories.new(params[:categoryform])
      if request.post?
        @newCategory.save
      
      end
  end

  def delete
     @currentCategory = @currentUser.categories.find_by_id(params[:id])
     @currentCategory.destroy
  end
  def edit

  end
  def show
    
  end
end
 