require 'rails_helper'

RSpec.describe Expense, type: :model do
  before(:all) do
    @user = User.create(name: 'Bushra', email: 'bushra@gmail.com', password: 'Melvin1')
    @expense = @user.expenses.create(name: 'Rent', amount: 500_000)
  end

  it 'is valid with valid attributes' do
    expect(@expense).to be_valid
  end

  it 'is not valid without a name' do
    @expense.name = nil
    expect(@expense).to_not be_valid
  end

  it 'is not valid without an amount' do
    @expense.amount = nil
    expect(@expense).to_not be_valid
  end

  it 'is not valid without a user' do
    @expense.user_id = nil
    expect(@expense).to_not be_valid
  end

  it 'is not valid with a negative amount' do
    @expense.amount = -1
    expect(@expense).to_not be_valid
  end

  it 'is not valid with a zero amount' do
    @expense.amount = 0
    expect(@expense).to_not be_valid
  end

  # validate associations
  describe 'Expense Associations' do
    it 'should have many exp_cats' do
      assc = Expense.reflect_on_association(:exp_cats)
      expect(assc.macro).to eq(:has_many)
    end
    it 'should have many categories through exp_cat' do
      assc = Expense.reflect_on_association(:categories)
      expect(assc.macro).to eq(:has_many)
    end
    it 'should belong to user' do
      assc = Expense.reflect_on_association(:user)
      expect(assc.macro).to eq(:belongs_to)
    end
  end

  after(:all) do
    User.destroy_all
    Expense.destroy_all
  end
end
