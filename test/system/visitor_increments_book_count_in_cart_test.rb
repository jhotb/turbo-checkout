require "application_system_test_case"

class VisitorIncrementsBookCountInCartTest < ApplicationSystemTestCase
  test "visitor increments book count in cart" do
    ruby_science = books(:ruby_science)
    order = Order.create!(books: [ruby_science])

    visit root_path(as: order)
    expand_cart
    within_line_item(ruby_science) do
      click_on "+"
    end

    within_cart do
      assert_text ruby_science.title, count: 1
      assert_text copy_count(2)
      assert_total ruby_science.price, ruby_science.price
    end
  end
end
