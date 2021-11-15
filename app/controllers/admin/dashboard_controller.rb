class Admin::DashboardController < ApplicationController
  def show
    @num_products = Product.all.count
    @num_categories = Category.all.count
  end
end
