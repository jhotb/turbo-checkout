require "application_system_test_case"

class VisitorDecrementsBookCountInCartTest < ApplicationSystemTestCase
  test "visitor decrements book count in cart test" do
    ruby_science = books(:ruby_science)
    order = Order.create!
    order.line_items.create!(book: ruby_science, quantity: 2)

    visit root_path(as: order)
    expand_cart
    within_line_item(ruby_science) do
      click_on "-"
    end

    within_cart do
      assert_text ruby_science.title, count: 1
      assert_text copy_count(1)
      assert_total ruby_science.price
    end
  end
end
