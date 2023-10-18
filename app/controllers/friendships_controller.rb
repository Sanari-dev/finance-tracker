class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:friend])
    if !user.blank?      
      @friends = Friendship.create(user_id: params[:user], friend_id: params[:friend])
      flash[:notice] = "#{user.email} was successfully added to your friend list"
    else
      flash[:alert] = "Couldn't find user"
    end    
    redirect_to my_friends_path
  end
  
  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.where(user_id: current_user.id, friend_id: friend.id).first
    friendship.destroy
    flash[:notice] = "#{friend.full_name} was successfully removed from your friend list"
    redirect_to my_friends_path
  end
end