class SubsController < ApplicationController

  before_action :ensure_moderator!, only: [:edit, :update, :destroy]
  before_action :ensure_current_user!, only: [:new, :create]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      flash[:notice] = "#{ @sub.title } created successfully"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      flash[:notice] = "#{@sub.title} updated successfully"
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
  end

  private

  def ensure_moderator!
    @sub = Sub.find(params[:id])
    redirect_to subs_url unless current_user == @sub.moderator
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
