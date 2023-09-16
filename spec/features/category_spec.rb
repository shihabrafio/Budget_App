require 'rails_helper'

RSpec.describe 'Categories', type: :feature do
  before(:each) do
    @user = User.create!(name: 'Rafio', email: 'rafio@gmail.com', password: '123456', password_confirmation: '123456')
    @category = @user.categories.create(name: 'Rent', icon: 'fas fa-home')
    visit new_user_session_path
    fill_in 'Email', with: 'rafio@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end
  it 'signs users in' do
    expect(current_path).to eq("/user/#{@user.id}/category")
  end

  it 'should include template text' do
    expect(page).to have_content('Signed in successfully')
  end

  it 'Navigates to add new category page' do
    click_link 'Add new Category'
    expect(current_path).to eq("/user/#{@user.id}/category/new")
    expect(page).to have_content('Add a new Category')
  end

  it 'Creates a new category' do
    visit new_user_category_path(@user.id)
    expect(page).to have_content('Add a new Category')
    fill_in 'user_name', with: 'Groceries'
    fill_in 'user_icon', with: 'fas fa-shopping-cart'
    click_button 'Add Category'
    expect(page).to have_content('Category was successfully created.')
  end

  it 'Navigates to homepage when user clicks on back button' do
    visit new_user_category_path(@user.id)
    expect(page).to have_content('Add a new Category')
    click_link 'Back'
    expect(current_path).to eq("/user/#{@user.id}/category")
  end

  after(:all) do
    User.destroy_all
    Category.destroy_all
  end
end
