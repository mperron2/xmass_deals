class SupportController < ApplicationController
  def show
    if params[:page] == "about"
      @page = About.first
    elsif params[:page] == "contact"
      @page = Contact.first
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end
  end
end
