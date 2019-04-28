class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :get_categories, only: [:new, :edit, :show, :create]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all.order(:lft)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @view_name = params[:view] if params[:view]
    respond_to do |format|
      if @category
        format.html { render :show }
        format.js   {}
        format.json { render json: @category_details }
      else
        format.json { render json: @category_details.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /categories/new
  def new
     @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if  @category.save
        format.html { redirect_to  @category, notice:  'category was successfully created.' }
        format.json { render :show, status: :created, location:  Category }
      else
        format.html { render :new }
        format.json { render json:  @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if  @category.update(category_params)
        format.html { redirect_to  @category, notice:  'Category was successfully updated.' }
        format.json { render :show, status: :ok, location:  @category }
      else
        format.html { render :edit }
        format.json { render json:  @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice:  'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def get_categories
      @categories = Category.all.select(:name,:id,:depth).order(:lft)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :parent_id, :lft, :rgt, :depth, :children_count, category_details: {})
    end
end
