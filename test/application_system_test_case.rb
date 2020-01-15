require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include ActionView::Helpers::NumberHelper

  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  def assert_rich_text(rich_text)
    within ".trix-content" do
      assert_text(rich_text.to_plain_text.squish, normalize_ws: true)
    end
  end
end
