class ProductFilesController < ApplicationController
  before_action :set_product_file, only: [:show, :edit, :update, :destroy]

  # GET /product_files
  # GET /product_files.json
  def index
    @product_files = ProductFile.all
  end

  # GET /product_files/1
  # GET /product_files/1.json
  def show
  end

  # GET /product_files/new
  def new
    @product_file = ProductFile.new
  end

  # GET /product_files/1/edit
  def edit
  end

  # POST /product_files
  # POST /product_files.json
  def create
    @product_file = ProductFile.new(product_file_params)

    respond_to do |format|
      if @product_file.save
        format.html { redirect_to @product_file, notice: 'Product file was successfully created.' }
        format.json { render :show, status: :created, location: @product_file }
      else
        format.html { render :new }
        format.json { render json: @product_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_files/1
  # PATCH/PUT /product_files/1.json
  def update
    respond_to do |format|
      if @product_file.update(product_file_params)
        format.html { redirect_to @product_file, notice: 'Product file was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_file }
      else
        format.html { render :edit }
        format.json { render json: @product_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_files/1
  # DELETE /product_files/1.json
  def destroy
    @product_file.destroy
    respond_to do |format|
      format.html { redirect_to product_files_url, notice: 'Product file was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_file
      @product_file = ProductFile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_file_params
      params.require(:product_file).permit(:_id, :name)
    end
end
