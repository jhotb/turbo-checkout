class LineItemsController < ApplicationController
  def create
    line_item = Current.order.line_items.find_or_initialize_by(line_item_params)

    line_item.increment!

    cookies[:order_token] = Current.order.token

    redirect_back(
      fallback_location: root_url,
      flash: { success: translate(".success", title: line_item.title) },
    )
  end

  def update
    line_item = Current.order.line_items.find(params[:id])

    line_item.update!(params.require(:line_item).permit(:quantity))

    redirect_back fallback_location: root_url
  end

  def destroy
    line_item = Current.order.line_items.find(params[:id])

    line_item.destroy!

    redirect_back(
      fallback_location: root_url,
      flash: { success: translate(".success", title: line_item.title) },
    )
  end

  private

  def line_item_params
    params.require(:line_item).permit(:book_id)
  end
end
