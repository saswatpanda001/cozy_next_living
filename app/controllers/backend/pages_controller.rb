module Backend
    class PagesController < Backend::BaseController
      before_action :set_page, only: [:edit, :update, :destroy]
  
      def index
        @pages = Page.all.order(created_at: :desc)
      end
  
      def edit
      end
  
      def update
        if @page.update(page_params)
          redirect_to backend_pages_path, notice: 'Page was successfully updated.'
        else
          render :edit
        end
      end
  
      def destroy
        @page.destroy
        redirect_to backend_pages_url, notice: 'Page was successfully deleted.'
      end
  
      private
  
      def set_page
        @page = Page.find(params[:id])
      end
  
      def page_params
        params.require(:page).permit(
          :title, :slug, :content, :phone, :email, 
          :address, :contact_info, :about_description1, :about_description2
        )
      end
    end
  end
  