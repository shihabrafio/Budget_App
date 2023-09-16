class Category < ApplicationRecord
  belongs_to :user
  has_many :exp_cats
  has_many :expenses, through: :exp_cats, dependent: :destroy

  validates :name, :icon, presence: true
  def sum_amount
    expenses.sum(:amount)
  end
end
