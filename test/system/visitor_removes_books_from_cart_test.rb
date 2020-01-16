require "application_system_test_case"

class VisitorRemovesBooksFromCartTestTest < ApplicationSystemTestCase
  test "visitor removes books from cart test" do
    ruby_science = books(:ruby_science)
    testing_rails = books(:testing_rails)
    order = Order.create!(books: [ruby_science, testing_rails])

    visit root_path(as: order)
    expand_cart
    within_line_item(testing_rails) do
      click_on remove_line_item
    end

    assert_text removed_book_flash(testing_rails)
    within_cart do
      assert_text ruby_science.title
      assert_no_text testing_rails.title
      assert_total ruby_science
    end
  end

  def removed_book_flash(book)
    translate("line_items.destroy.success", title: book.title)
  end

  def remove_line_item
    translate("helpers.submit.line_item.update")
  end
end
