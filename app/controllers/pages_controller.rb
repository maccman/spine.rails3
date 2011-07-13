class PagesController < ApplicationController
  respond_to :html, :json
  
  def index
    @pages = Page.all
    respond_with @pages
  end

  def show
    @page = Page.find(params[:id])
    respond_with @page
  end

  def new
    @page = Page.new
    respond_with @page
  end
  
  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      respond_with(@page, status: :created, location: @page)
    else
      respond_with(@page.errors, status: :unprocessable_entity) 
    end
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      respond_with(@page)
    else
      respond_with(@page.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    head :ok
  end
end