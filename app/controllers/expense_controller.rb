class ExpenseController < ApplicationController
  def new
    @expense = Expense.new
  end

  def index
    @category = Category.find(params[:category_id])
    @expenses = @category.expenses.order('created_at DESC')
  end

  def create
    @user = current_user
    @expense = @user.expenses.new(expense_params)
    if @expense.save && check_category_id
      @expense.exp_cats.create(category_id_func)
      flash[:notice] = 'Expense created successfully'
      redirect_to expense_index_path({ category_id: category_id_func[:category_id] })
    else
      flash[:alert] = 'Expense not created'
      render 'new'
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end

  def category_id_func
    params.require(:expense).permit(:category_id)
  end

  def check_category_id
    category_id_func[:category_id] != ''
  end
end
