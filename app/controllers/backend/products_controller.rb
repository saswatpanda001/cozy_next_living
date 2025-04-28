
module Backend
    class ProductsController < Backend::BaseController
      before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :set_categories, only: [:new, :edit, :create, :update]

    def index
      @products = Product.includes(:category).order(created_at: :desc).page(params[:page])
    end

    def show
    end

    def new
      @product = Product.new
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to backend_product_path(@product), notice: 'Product was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @product.update(product_params)
        redirect_to backend_product_path(@product), notice: 'Product was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @product.destroy
      redirect_to backend_products_url, notice: 'Product was successfully destroyed.'
    end

    private

    def set_product
      @product = Product.find(params[:id])
    end

    def set_categories
      @categories = Category.all
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :category_id, 
                                     :on_sale, :new_arrival, :image)
    end
  end
  
  end