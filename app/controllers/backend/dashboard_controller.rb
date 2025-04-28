class Backend::DashboardController < Backend::BaseController
  def index
    @products_count = Product.count
    @categories_count = Category.count
    @pages_count = Page.count
  end
  end