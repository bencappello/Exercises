class AlbumsController < ApplicationController

  def new
    @album = Album.new
    @band_id = params[:band_id].to_i
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      @band_id = @album.band.id
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    @band_id = @album.band.id
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      @band_id = @album.band.id
      render :edit
    end
  end

  def destroy
    @album = Album.new(album_params)
    @album.destroy
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :name, :album_type)
  end
end
