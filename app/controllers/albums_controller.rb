class AlbumsController < ApplicationController

  def show

  end

  def edit
  end

  def update
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :name, :album_type)
  end
end
