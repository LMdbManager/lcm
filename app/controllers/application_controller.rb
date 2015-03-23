class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  include Pundit
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  helper :show_object
  
  #def current_user
  #  puts "Pundit is looking for current_user"
  #  current_person
  #end
  
  private
  
  def configure_permitted_parameters
    puts "!!!!Checking params"
    devise_parameter_sanitizer.for(:sign_up) {|u|
      u.permit(:firstname, :lastname, :email, :password, :password_confirmation)
    }
    devise_parameter_sanitizer.for(:account_update) {|u|
      u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :current_password)
    }
  end
  
end