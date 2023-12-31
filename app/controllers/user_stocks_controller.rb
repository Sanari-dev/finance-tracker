class UserStocksController < ApplicationController
  def create
    stock = Stock.check_stock(params[:ticker])
    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    @user_stocks = UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} was successfully added to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find(params[:id])
    if(stock.users.find(current_user.id))
      user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
      user_stock.destroy
      flash[:notice] = "#{stock.ticker} was successfully removed from your portfolio"
    else
      flash[:alert] = "Only the owner cant delete this stock"
    end
    redirect_to my_portfolio_path
  end
end
