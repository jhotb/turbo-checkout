class ApplicationController < ActionController::Base
  before_action :ensure_current_order

  def ensure_current_order
    order_token = cookies[:order_token]

    if order_token.present?
      Current.order = Order.find_by(token: order_token)
    end

    Current.order ||= Order.new
  end
end
