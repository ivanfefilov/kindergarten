class PagesController < ApplicationController
   before_action :authenticate_user!, only: :home
   
   def home
     redirect_to posts_path if current_user && current_user.approved?
     render(:user_not_approved) && return if current_user && !current_user.approved?
   end
   
   def game
     render layout: "game"
   end          
end
