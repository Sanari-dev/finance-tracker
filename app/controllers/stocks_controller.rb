class StocksController < ApplicationController
  def search
    @tracked_stocks = current_user.stocks
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        render 'users/my_portfolio'
      else
        flash_alert_invalid
      end      
    else
      flash_alert_invalid
    end
  end

  private 
  
  def flash_alert_invalid
    flash[:alert] = "Please enter a valid symbol to search"
    redirect_to my_portfolio_path
  end
end