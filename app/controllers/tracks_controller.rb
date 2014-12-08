class TracksController < ApplicationController

  def show

  end

  def edit
  end

  def update
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :name, :track_type, :lyrics)
  end
end
