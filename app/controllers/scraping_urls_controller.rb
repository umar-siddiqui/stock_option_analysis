class ScrapingUrlsController < ApplicationController
  def index
    respond_to do |format|
      format.html do render :index end
      format.json do
        render json: ScrappingUrl.all
      end
    end
  end

  def new
    render :new
  end

  def create
    url = ScrappingUrl.new(permitted_params)
    url.save!
    render json: url
  end

  def update
    url = ScrappingUrl.find(params[:_id])
    url.update_attributes!(permitted_params)
    render json: url
  end

  def edit
    render :new
  end

  def show
    render :show
  end

  def destroy
    url = ScrappingUrl.find(params[:_id])
    url.destroy!
    render json: url
  end

  private

  def permitted_params
    params.require(:scrapping_url).permit(
      :name,
      :url
    )
  end
end
