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
      assert_total book.price
    end
  end

  test "visitor adds Book to their Cart more than once" do
    ruby_science = books(:ruby_science)

    visit root_path
    click_on ruby_science.title
    2.times { click_on translate("helpers.submit.line_item.create") }
    expand_cart

    within_cart do
      assert_text ruby_science.title, count: 1
      assert_text copy_count(2)
      assert_total ruby_science.price, ruby_science.price
    end
  end

  def copy_count(count)
    translate("orders.order.table.line_item.quantity", count: count)
  end

  def added_book_flash(book)
    translate("line_items.create.success", title: book.title)
  end
end
