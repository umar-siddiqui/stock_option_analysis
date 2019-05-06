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
    url = ScrappingUrl.find(params[:id])
    url.update_attributes!(permitted_params)
    render json: url
  end

  def edit
    render :new
  end

  def show
    respond_to do |format|
      format.html do
        render :show
      end

      format.json do
        url = ScrappingUrl.find(params[:id])
        render json: url, serializer: ScrappingUrlShowSerializer
      end
    end
  end

  def destroy
    url = ScrappingUrl.find(params[:id])
    url.destroy!
    render json: url
  end

  def calculate_pbox
    url = ScrappingUrl.find(params[:scraping_url_id])
    pbox = ScrapingUrlsHelper::Pbox.new(url).calculate
    render json: pbox
  end

  def calculate_all_pbox
    ScrappingUrl.all.each do |url|
      ScrapingUrlsHelper::Pbox.new(url).calculate
    end
    render json: { completed: true }
  end

  private

  def permitted_params
    params.require(:scrapping_url).permit(
      :name,
      :url
    )
  end
end
