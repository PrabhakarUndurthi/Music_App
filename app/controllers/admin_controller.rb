class AdminController < ApplicationController
  
  layout 'admin'

  before_filter :authorize_access, :except => [:login, :send_login]

    def index
      menu
      render(:action => 'menu')
    end
  
    def menu
      # no instance variables declared, just a page of links
    end
    
    def login
      @user = User.new
    end
    

  # when the user logged in to the site , it checks whether the credentials are not matched 
  # or not, if matched it redirect the user to the login page and display the menu.
    def send_login
      @user = User.new(params[:user])
      logged_in_user = @user.try_to_login
      if logged_in_user
        session[:user_id] = logged_in_user.id
        flash[:notice] = "You are now logged in."
        redirect_to(:action => 'menu')
      else
        flash[:notice] = "Username/password combination incorrect. Please make sure your caps lock key is off and try again."
        redirect_to(:action => 'login')
      end
    end


    # if the user logged out from the site, it redirect the user to the default login page.
    
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "You are now logged out."
    redirect_to(:action => 'login')
  end
    
  
end
