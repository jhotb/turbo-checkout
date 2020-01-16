require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  test ".total_in_cents" do
    ruby_science = books(:ruby_science)
    testing_rails = books(:testing_rails)
    order = Order.create!
    order.line_items.create!(book: ruby_science, quantity: 2)
    order.line_items.create!(book: testing_rails, quantity: 3)

    total_in_cents = LineItem.all.total_in_cents

    assert_equal(
      (ruby_science.price_in_cents * 2) + (testing_rails.price_in_cents * 3),
      total_in_cents,
    )
  end

  test "#increment! before create sets the quantity to the default value" do
    ruby_science = books(:ruby_science)
    order = Order.create!
    line_item = LineItem.new(order: order, book: ruby_science)

    line_item.increment!

    assert_equal 1, line_item.quantity
  end

  test "#increment! increases the quantity" do
    ruby_science = books(:ruby_science)
    order = Order.create!
    line_item = order.line_items.create!(book: ruby_science, quantity: 2)

    line_item.increment!

    assert_equal 3, line_item.quantity
  end
end
