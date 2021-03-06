class PortfoliosController < ApplicationController
  before_action :set_portfolio_item, only:[:edit, :update, :destroy, :show]
  layout "portfolio"
  access all: [:show, :index],
    user: {except: [:destroy, :new, :create, :update, :edit, :sort]}, 
    site_admin: :all
  def index
    @portfolio_items = Portfolio.by_position
  end

  def sort
    params[:order].each do |key, value|
      Portfolio.find(value[:id]).update(position: value[:position])
    end

    head :ok
  end

  def show
  end

  def new
    @portfolio_item = Portfolio.new
    3.times { @portfolio_item.technologies.build }
  end

  def create
    @portfolio_item = Portfolio.new(portfolio_params)
    if @portfolio_item.save
      redirect_to portfolios_path, notice: "Your portfolio item has been created"
    else 
      render :new
    end
  end

  def edit
  end

  def update
    if @portfolio_item.update(portfolio_params)
      redirect_to portfolios_path, notice: "Portfolio item has been updated"
    else 
      render :edit
    end
  end

  def destroy
    @portfolio_item.destroy
    redirect_to portfolios_path, notice: "Portfolio item deleted"
  end

  private
  
  def portfolio_params
    params.require(:portfolio).permit(:title, 
                                      :subtitle,
                                      :main_image,
                                      :thumb_image,
                                      :body,
                                      technologies_attributes: [:name]
                                     )
  end

  def set_portfolio_item
    @portfolio_item = Portfolio.find(params[:id])
  end
end
