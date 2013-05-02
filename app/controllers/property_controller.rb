class PropertyController < ApplicationController
  # GET /
  def index
    @properties = Property.all
    render 'index'
  end

  # POST /search
  def search
    @properties = Property.search(params[:q])
    render 'index'
  end

  # GET /show/:id
  def show
    @property = Property.find_by_id(params[:id])
    if @property.nil?
      render 'public/404', :status => :not_found
    else
      @nearby_properties = Property.near([@property.latitude, @property.longitude], 20, :units => :km)
      @nearby_properties.reject! { |p| p == @property }
      render 'show'
    end
  end
end
