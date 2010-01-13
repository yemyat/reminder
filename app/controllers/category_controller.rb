class CategoryController < ApplicationController
  def create
      @newCategory = Category.new(params[:categoryform])
      if request.post?
        @newCategory.save
      end
  end

  def delete
     @currentCategory = Category.find_by_id(params[:id])
     @currentCategory.destroy
  end

end
