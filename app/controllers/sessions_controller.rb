class SessionsController < ApplicationController
    def new
    end
  
    def create
        user = Admin.find_by(username: params[:username])
        
        if user&.authenticate(params[:password])
          session[:admin_id] = user.id
          
          respond_to do |format|
            if user.administrator?
              format.html { redirect_to backend_dashboard_index_path, notice: 'Logged in successfully' }
              format.turbo_stream { redirect_to backend_dashboard_index_path, status: :see_other }
            else
              format.html { redirect_to products_path, notice: 'Logged in successfully' }
              format.turbo_stream { redirect_to products_path, status: :see_other }
            end
          end
        else
          flash.now[:alert] = 'Invalid username or password'
          render :new, status: :unprocessable_entity
        end
      end
      
  
      def destroy
        session[:admin_id] = nil  
        redirect_to root_path, notice: 'Logged out successfully'
      end
  end