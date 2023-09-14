require 'rails_helper'

RSpec.describe ExpCat, type: :model do
  describe 'ExpCat Associations' do
    it 'should belong to category' do
      assc = ExpCat.reflect_on_association(:category)
      expect(assc.macro).to eq(:belongs_to)
    end
    it 'should belong to expense' do
      assc = ExpCat.reflect_on_association(:expense)
      expect(assc.macro).to eq(:belongs_to)
    end
  end
end
