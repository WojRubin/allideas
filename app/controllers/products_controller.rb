class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :get_categories, only: [:index, :new, :edit, :show]

  # GET /orders
  # GET /orders.json
  def index
    if params[:category_id]
      category = Category.find(params[:category_id])
      @products = Product.joins(:category).where('categories.lft >= ? AND categories.rgt <= ? AND  lower(products.name) LIKE ?', category.lft, category.rgt, "%#{params[:name].downcase}%").includes(:category).order(:name)
      @products = selections(category,@products)
    else
      @products = Product.includes(:category).order(:name)
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @product = Product.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def selections category, products
    if category
      if category.category_details
        category.category_details.each_with_index do |(k,v),index|
          if params[:q] && params[:q]["category_details_#{k}_matches_any"] && !params[:q]["category_details_#{k}_matches_any"].first.empty?
            field_p = params[:q]["category_details_#{k}_matches_any"]
            field = field_p.to_s.tr(?\",?')
            query = "product_details-> '" + k.to_s + "' ?| " + 'array' + field
            products = products.where(query)
          elsif params[:q] && params[:q]["category_details_#{k}_i_min"] && params[:q]["category_details_#{k}_i_max"] && params[:q]["category_details_#{k}_i_include"]
            field_min = params[:q]["category_details_#{k}_i_min"].first
            field_max = params[:q]["category_details_#{k}_i_max"].first
            products = products.where("(product_details->> '#{k.to_s}')::Integer >= ? AND (product_details->> '#{k.to_s}')::Integer <= ?", field_min.to_i, field_max.to_i)
          elsif params[:q] && params[:q]["category_details_#{k}_dec_min"] && params[:q]["category_details_#{k}_dec_max"] && params[:q]["category_details_#{k}_dec_include"]
            field_min = params[:q]["category_details_#{k}_dec_min"].first
            field_max = params[:q]["category_details_#{k}_dec_max"].first
            products = products.where("(product_details->> '#{k.to_s}')::Decimal >= ? AND (product_details->> '#{k.to_s}')::Decimal <= ?", field_min.to_d, field_max.to_d)
          end
        end
      end
    end
    return products
  end

  private
    def get_categories
      @categories = Category.all.select(:name,:id,:depth).order(:lft)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :category_id, product_details: {} )
    end
end
