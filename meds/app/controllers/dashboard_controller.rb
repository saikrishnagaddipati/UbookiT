class DashboardController < ApplicationController
  def index
  	@orders = Order.active_orders
  end
end
