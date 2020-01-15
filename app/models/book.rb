class Book < ApplicationRecord
  has_one_attached :cover

  has_rich_text :description

  def price
    price_in_cents / 100
  end
end
