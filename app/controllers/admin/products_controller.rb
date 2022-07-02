class Admin::ProductsController < ApplicationController
  
  http_basic_authenticate_with name: "bob", password: "bob" 
  # before_action :authenticate

  # def authenticate
  #   authenticate_or_request_with_http_basic('Administration') do |username, password|
  #     md5_of_password = Digest::MD5.hexdigest(password)
  #     username == ENV['BASIC_AUTH_USERNAME'] && md5_of_password == ENV['BASIC_AUTH_PASSWORD']
  #   end
  # end

  def index
    @products = Product.order(id: :desc).all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      render :new
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    redirect_to [:admin, :products], notice: 'Product deleted!'
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end

end
