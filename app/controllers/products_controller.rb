class ProductsController < ApplicationController
    def index
        @categories = Category.all
        @products = Product.includes(:category)
      
        @products = @products.filter_by_category(params[:category_id]) if params[:category_id].present?
        @products = @products.filter_by_sale_status(params[:sale_status]) if params[:sale_status].present?
        @products = @products.search_by_name(params[:search]) if params[:search].present?
        @products = @products.new_arrivals if params[:new_arrivals] == "1"
      
        @products = @products.page(params[:page]).per(12)
      end
  
    def show
      @product = Product.includes(:category).find(params[:id])
      @related_products = @product.category.products
                                 .where.not(id: @product.id)
                                 .order(created_at: :desc)
                                 .limit(4)
    end
  end