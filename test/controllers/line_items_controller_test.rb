require "test_helper"

class LineItemsControllerTest < ActionDispatch::IntegrationTest
  test "#create without an existing Order creates a new Order" do
    ruby_science = books(:ruby_science)

    post line_items_path, params: {
      line_item: { book_id: ruby_science.to_param },
    }
    current_order = Order.last

    assert_equal 1, Order.count, "creates a new Order record"
    assert_equal cookies[:order_token], current_order.token, "stores Order token in cookie"
    assert_equal [ruby_science.title], current_order.books.pluck(:title), "creates the line item"
  end

  test "#create with an existing Order re-uses the Order" do
    ruby_science = books(:ruby_science)
    order = Order.create!
    cookies[:order_token] = order.token

    post line_items_path, params: {
      line_item: { book_id: ruby_science.to_param },
    }
    current_order = Order.last

    assert_equal 1, Order.count, "does not create a new Order record"
    assert_equal cookies[:order_token], current_order.token, "does not override the cookie"
    assert_equal [ruby_science.title], current_order.books.pluck(:title), "creates the line item"
  end

  test "#create with an Order token referencing a deleted Order" do
    ruby_science = books(:ruby_science)
    cookies[:order_token] = "abc123"

    post line_items_path, params: {
      line_item: { book_id: ruby_science.to_param },
    }
    current_order = Order.last

    assert_equal 1, Order.count, "creates a new Order"
    assert_not_equal cookies[:order_token], "abc123", "overrides the stale token cookie"
    assert_equal cookies[:order_token], current_order.token, "sets the new token cookie"
    assert_equal [ruby_science.title], current_order.books.pluck(:title), "creates the line item"
  end
end
