class LineItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  delegate_missing_to :book

  def self.total
    joins(:book).sum("books.price_in_cents")
  end
end
