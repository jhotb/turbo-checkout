require "application_system_test_case"

class VisitorViewsABookTest < ApplicationSystemTestCase
  test "visitor views a book" do
    book = books(:ruby_science)

    visit root_path
    click_on book.title

    assert_text book.title
    assert_text number_to_currency(book.price)
    assert_rich_text book.description
  end
end
