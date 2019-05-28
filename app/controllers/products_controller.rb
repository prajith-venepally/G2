class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all

    render json: @products
  end

  def show
    render json: @product
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
  end

  def search
    sub_category = params[:sub_category]
    email = params[:email]
    product = params[:product]
    user = User.find_by_email(email)
    if sub_category
      sub_category = SubCategory.find_by_name(sub_category)
      products = sub_category.products.order(internal_score: :desc)
      Search.create(search_text: sub_category.name, searchable: sub_category, user: user)
      render json: {"products" => products}
    else
      product = Product.find_by_name(product)
      Search.create(search_text: product.name, searchable: product, user: user)
      render json: {"product" => product}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.require(:product).permit(:name, :internal_score, :sub_category_id)
    end
end
