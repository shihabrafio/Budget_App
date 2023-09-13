class Expense < ApplicationRecord
    belongs_to :user
    has_many :exp_cats
    has_many :categories, through: :exp_cats
  
    validates :name, :amount, presence: true
    validates :amount, numericality: { greater_than: 0 }
  end