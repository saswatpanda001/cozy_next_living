# app/controllers/admins_controller.rb
class AdminsController < ApplicationController
    def new
      @admin = Admin.new
      @provinces = Province.all
    end
  
    def create
      @admin = Admin.new(admin_params)
      if @admin.save
        redirect_to login_path, notice: 'Admin created successfully. Please login.'
      else
        @provinces = Province.all
        render :new
      end
    end
  
    private
  
    def admin_params
      params.require(:admin).permit(:username, :password, :password_confirmation, :province_id)
    end
  end
  