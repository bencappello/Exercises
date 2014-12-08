class BandsController < ApplicationController

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      redirect_to bands_url(:id)
    else
      flash.now[:errors] = ["Incomplete information."]
      render :new
    end
  end

  def show

  end

  def edit
  end

  def update
  end

  def destroy
    @band = Band.new(band_params)
    @band.destroy
  end


  private

  def band_params
    params.require(:band).permit(:name)
  end
end
