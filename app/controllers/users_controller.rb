class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user
  end

  def my_friends
    @friends = current_user.friends
  end

  def search    
    @friends = current_user.friends
    if params[:user].present?      
      @friendlist = User.search_user(params[:user])
      if @friendlist
        render 'users/my_friends'
      else
        flash_alert_invalid
      end      
    else
      flash_alert_invalid
    end
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  private 
  
  def flash_alert_invalid
    flash[:alert] = "User doesn't exist"
    redirect_to my_friends_path
  end  
end
