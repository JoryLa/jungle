class Admin::CategoriesController < ApplicationController
  
  http_basic_authenticate_with name: "bob", password: "bob" 

  def index
    @categories = Category.order(id: :desc).all
  end
  
  # @categories = Category.all.collect(&:name)
  
  # puts ActiveRecord::Base.connection.columns('categories').map(&:name)
  # puts Category.select('name').find_by(id: 1).to_s
  # puts Category.all.collect(&:name)
  # puts ActiveRecord::Base.connection.tables
  # puts "HELLLO"

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
  

