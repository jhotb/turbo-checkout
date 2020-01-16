class LineItem < ApplicationRecord
  belongs_to :book
  belongs_to :order

  validates :quantity, numericality: { greater_than: 0 }

  delegate_missing_to :book

  def self.total_in_cents
    joins(:book).sum("books.price_in_cents * line_items.quantity")
  end

  def increment!
    if persisted?
      assign_attributes(quantity: quantity + 1)
    end

    save!
  end
end
