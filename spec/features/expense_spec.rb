require 'rails_helper'

RSpec.describe 'Expenses', type: :feature do
  before(:each) do
    @user = User.create(name: 'John', email: 'john@gmail.com', password: '123456', password_confirmation: '123456')
    @category = @user.categories.create(name: 'Food', icon: 'fas fa-home')

    visit new_user_session_path
    fill_in 'Email', with: 'john@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  it 'signs users in' do
    expect(current_path).to eq("/user/#{@user.id}/category")
  end

  it 'Creates a new category' do
    visit new_user_category_path(@user.id)
    fill_in 'user_name', with: 'Groceries'
    fill_in 'user_icon', with: 'fas fa-shopping-cart'
    click_button 'Add Category'
    expect(page).to have_content('Category was successfully created')
  end

  it 'Navigates to the Expense page' do
    visit new_user_category_path(@user.id)
    fill_in 'user_name', with: 'Groceries'
    fill_in 'user_icon', with: 'fas fa-shopping-cart'
    click_button 'Add Category'
    visit "/user/#{@user.id}/category"
    click_on('Groceries')
    expect(current_path).to eq('/expense')
  end

  it 'navigate to new expense page' do
    visit "/expense?category_id=#{@category.id}"
    expect(page).to have_content('Add new Expense')
    click_link 'Add new Expense'
    expect(current_path).to eq('/expense/new')
  end

  it 'creates a new expense' do
    visit "/expense/new?category_id=#{@category.id}"
    fill_in 'Expense', with: 'Watermelon'
    fill_in 'Amount', with: 100
    select 'Food', from: 'expense_category_id'
    click_button 'Save'
    expect(page).to have_content('Expense created successfully')
    expect(current_path).to eq('/expense')
  end

  it 'navigates back to index expense page' do
    visit "/expense/new?category_id=#{@category.id}"
    click_link 'Back'
    expect(current_path).to eq('/expense')
  end

  after(:all) do
    User.destroy_all
    Expense.destroy_all
  end
end