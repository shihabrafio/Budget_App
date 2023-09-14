require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.create(name: 'Rafio')
  end

  it 'is valid with valid attributes' do
    @user.name = nil
    expect(@user).to_not be_valid
  end

  # Validate associations
  describe 'User Associations' do
    it 'Should have many expenses' do
      assc = User.reflect_on_association(:expenses)
      expect(assc.macro).to eq(:has_many)
    end
    it 'Should have many categories' do
      assc = User.reflect_on_association(:categories)
      expect(assc.macro).to eq(:has_many)
    end
  end
end
