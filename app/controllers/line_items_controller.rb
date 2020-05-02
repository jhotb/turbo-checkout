class LineItemsController < ApplicationController
  def create
    line_item = Current.order.line_items.build(line_item_params)

    line_item.save!

    cookies[:order_token] = Current.order.token

    redirect_back_with_bzq(
      fallback_location: root_url,
      flash: { success: translate(".success", title: line_item.title) },
    )
  end

  def destroy
    line_item = Current.order.line_items.find(params[:id])

    line_item.destroy!

    redirect_back_with_bzq(
      fallback_location: root_url,
      flash: { success: translate(".success", title: line_item.title) },
    )
  end

  private

  def line_item_params
    params.require(:line_item).permit(:book_id)
  end
end
