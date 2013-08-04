class ShowcasesController < ApplicationController
  before_action :set_showcase, only: [:show, :edit, :update, :destroy, :remove_wine]
  layout false 

  def index
    @showcases = Showcase.all
  end

  def show
    @showcases_wines = @showcase.showcases_wines
    @wines = @showcase.wines
  end

  def new
    @showcase = Showcase.new
  end

  def edit
  end

  def create
    
    @showcase = Showcase.new(showcase_params)

    respond_to do |format|
      if @showcase.save
        format.html { redirect_to @showcase, notice: 'Showcase was successfully created.' }
        format.json { render action: 'show', status: :created, location: @showcase }
      else
        format.html { render action: 'new' }
        format.json { render json: @showcase.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @showcase.update(showcase_params)
        format.html { redirect_to @showcase, notice: 'Showcase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @showcase.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @showcase.destroy
    respond_to do |format|
      format.html { redirect_to showcases_url }
      format.json { head :no_content }
    end
  end

private

  def set_showcase

    @showcase = Showcase.find(params[:id])
  end

  def showcase_params
    params.require(:showcase).permit(
      :showcaseable_id, :showcaseable_type, :version, :name, :description, 
      :published, { wine: :wine_id })
  end
end
