class Api::V1::ProductsController < Api::V1::ApiController
  before_action :get_product, only: [:show, :update, :destroy]

  # Get /api/v1/products
  def index
    @products = Product.page(params[:page] ? params[:page] : 1)
    render json: @products,
            each_serializer: Api::V1::ProductsSerializer,
            status: :ok
  end

  # Get /api/v1/products/:id
  def show
    ensure_params(:id) and return
    if @product.present?
      render json: @product,
             serializer: Api::V1::ProductsSerializer,
             status: :ok
    else
      return render_api_error(01, 403, 'error', 'no record found')
    end

  end

  # Post /api/v1/products
  def create
    ensure_params(:name, :price, :description) and return
    if @product= Product.create(product_params)
      render json: @product,
             serializer: Api::V1::ProductsSerializer,
             status: :created
    else
      return render_api_error(01, 422, 'error', @product.errors)
    end
  end

  # Put /api/v1/products/:id
  def update
    ensure_params(:id) and return
    if @product.present?
       if @product.update_attributes(product_params)
          render json: @product,
                   serializer: Api::V1::ProductsSerializer,
                   status: :ok
        else
          return render_api_error(01, 422, 'error', @product.errors)
        end
    else
      return render_api_error(01, 403, 'error', 'no record found')
    end

  end

  # Delete /api/v1/products/:id
  def destroy
    ensure_params(:id) and return
   if @product.present? &&  @product.destroy
     render json: :ok
    else
      return render_api_error(01, 403, 'error', 'no record found')
    end
  end

  private

  def product_params
    params.permit(:name, :price, :description)
  end

  def get_product
    @product = Product.find_by_id(params[:id])
  end

end
