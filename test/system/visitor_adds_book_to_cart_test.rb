require "application_system_test_case"

class VisitorAddsBookToCartTest < ApplicationSystemTestCase
  test "visitor adds a Book to their Cart" do
    book = books(:ruby_science)

    visit root_path
    click_on book.title
    click_on translate("helpers.submit.line_item.create")
    expand_cart

    assert_text added_book_flash(book)
    within_cart do
      assert_text book.title
      assert_text number_to_currency(book.price)
    end
  end

  def added_book_flash(book)
    translate("line_items.create.success", title: book.title)
  end
end
