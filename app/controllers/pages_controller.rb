class PagesController < ApplicationController
  def about
    @page = Page.first || Page.new(title: 'About Us')
  end

  def contact
    @page = Page.first || Page.new(title: 'Contact Us')
  end

  def contact_submit
    # Handle contact form submission
    redirect_to contact_path, notice: "Thank you for your message! We'll get back to you soon."
  end
end
