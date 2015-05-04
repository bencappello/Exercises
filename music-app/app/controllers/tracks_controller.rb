class TracksController < ApplicationController

  def new
    @track = Track.new
    @album_id = params[:album_id].to_i
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      @album_id = @track.album.id
      render :new
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def edit
    @track = Track.find(params[:id])
    @album_id = @track.album.id
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      @album_id = @track.album.id
      render :edit
    end
  end

  def destroy
    @track = Track.new(track_params)
    @track.destroy
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :name, :track_type, :lyrics)
  end
end
