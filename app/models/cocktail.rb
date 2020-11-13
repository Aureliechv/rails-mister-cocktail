class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  has_one_attached :photo

  accepts_nested_attributes_for :doses
  validates_associated :doses

  validates :name, uniqueness: true, presence: true
end
