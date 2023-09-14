require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @user = User.create(name: 'Bushra', email: 'bushra@gmail.com', password: 'Melvin1')
    @category = Category.create(name: 'Rent', icon: 'fas fa-home', user_id: @user.id)
    @expense1 = Expense.create(name: 'Rent', amount: 16_000, user_id: @user.id)
    @expense2 = Expense.create(name: 'Makeup', amount: 8000, user_id: @user.id)
    ExpCat.create(expense_id: @expense1.id, category_id: @category.id)
    ExpCat.create(expense_id: @expense2.id, category_id: @category.id)
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(@category).to be_valid
    end

    it 'is not valid without a name' do
      @category.name = nil
      expect(@category).to_not be_valid
    end

    it 'is not valid without an icon' do
      @category.icon = nil
      expect(@category).to_not be_valid
    end

    it 'is not valid without a user' do
      @category.user_id = nil
      expect(@category).to_not be_valid
    end
  end

  context 'Custom methods' do
    it 'sums the amount of expenses' do
      expect(@category.sum_amount).to eq(24_000)
    end
  end

  # Validate associations
  describe 'Category Associations' do
    it 'Should have many expenses' do
      assc = Category.reflect_on_association(:expenses)
      expect(assc.macro).to eq :has_many
    end

    it 'Should have many exp_cats' do
      assc = Category.reflect_on_association(:exp_cats)
      expect(assc.macro).to eq :has_many
    end

    it 'Should belong to User' do
      assc = Category.reflect_on_association(:user)
      expect(assc.macro).to eq(:belongs_to)
    end
  end

  after(:all) do
    User.destroy_all
    Category.destroy_all
    Expense.destroy_all
    ExpCat.destroy_all
  end
end