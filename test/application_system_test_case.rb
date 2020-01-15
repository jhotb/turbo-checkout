require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::TranslationHelper

  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def expand_cart
    find("details", text: translate("layouts.application.cart")).click
  end

  def within_cart
    within("#order") { yield }
  end

  def assert_rich_text(rich_text)
    within ".trix-content" do
      assert_text(rich_text.to_plain_text.squish, normalize_ws: true)
    end
  end

  def assert_total(*prices)
    number_to_currency(prices.sum)
  end
end
