class Book < ApplicationRecord
  has_many :line_items

  has_one_attached :cover

  has_rich_text :description

  def price
    price_in_cents / 100
  end
end
