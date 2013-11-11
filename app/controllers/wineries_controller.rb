class WineriesController < ApplicationController

  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def index
    @page_title = "Wineries"

    @wineries = Winery.order(:created_at).page params[:page]

    respond_to do |format|
      format.html 
      format.json { render json: @wineries }
    end
  end

  def show

    # @winery = Winery.find(params[:id])
    @page_title = @winery.name
    @winery_wines = @winery.wines
    @wines = Kaminari.paginate_array(@winery_wines).page(params[:page]).per(4)
    @review = Review.new
    @reviews = @winery.reviews
    @winery.winery_rating

    respond_to do |format|
      format.html 
      format.json { render json: @winery }
    end

  end

  def new

    @producer = Producer.find_by_id(params[:producer_id])
    @winery = @producer.wineries.build

    respond_to do |format|
      format.html
      format.json { render json: @winery }
    end
  end

  def edit

  end

  def create
    
    @winery = Winery.new(winery_params)

    respond_to do |format|
      if @winery.save
        format.html { redirect_to @winery, notice: 'Winery was successfully created.' }
        format.json { render json: @winery, status: :created, location: @winery }
      else
        format.html { render action: "new" }
        format.json { render json: @winery.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @winery.update_attributes(params[:winery])
        format.html { redirect_to @winery, notice: 'Winery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @winery.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @winery.destroy

    respond_to do |format|
      format.html { redirect_to wineries_url }
      format.json { head :no_content }
    end
  end

private

  def set_winery
    @winery = Winery.find(params[:id])
  end

  def winery_params
    params.require(:winery).permit(:name, :producer_id, :slug)
  end
end
