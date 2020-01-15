require "application_system_test_case"

class VisitorViewsBooksInCartTest < ApplicationSystemTestCase
  test "visitor views Books in their Cart" do
    ruby_science = books(:ruby_science)
    testing_rails = books(:testing_rails)
    order = Order.create!(books: [ruby_science, testing_rails])

    visit root_path(as: order)
    expand_cart

    within_cart do
      assert_text ruby_science.title
      assert_text testing_rails.title
      assert_total ruby_science.price, testing_rails.price
    end
  end
end
