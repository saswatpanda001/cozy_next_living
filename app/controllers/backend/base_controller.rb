class Backend::BaseController < ApplicationController
    before_action :require_admin
  
    private
  
    def require_admin
      unless current_admin
        redirect_to login_path, alert: 'You must be logged in to access this page'
      end
    end
  
    def current_admin
      @current_admin ||= Admin.find_by(id: session[:admin_id]) if session[:admin_id]
    end
    helper_method :current_admin
  end