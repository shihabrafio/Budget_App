class CategoryController < ApplicationController
  def index
    @user = current_user
    @categories = @user.categories.order('created_at DESC')
  end

  def new
    @category = Category.new
  end

  def create
    @user = User.find(params[:user_id])
    @category = @user.categories.new(category_params)
    if @category.save
      redirect_to user_category_index_path(current_user)
      flash[:notice] = 'Category was successfully created.'
    else
      flash[:alert] = 'Category was not created.'
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
