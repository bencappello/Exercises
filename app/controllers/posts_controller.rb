class PostsController < ApplicationController
  before_action :ensure_author!, only: [:edit, :update, :destroy]
  before_action :ensure_current_user!, only: [:new, :create]

  def new
    @post = Post.new
    @sub_ids = [params[:sub_id]]
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if params[:sub_ids] == [""]
      @sub_ids = params[:sub_ids]
      flash.now[:errors] = ["Must select a sub"]
      render :new
    elsif @post.save
      @post.update_subs(params[:sub_ids])
      flash[:notice] = "#{@post.title} added successfully"
      redirect_to post_url(@post)
    else
      @sub_ids = params[:sub_ids]
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @sub_ids = @post.subs.pluck(:id).map(&:to_s)
  end

  def update
    @post = Post.find(params[:id])
    if params[:sub_ids] == [""]
      @sub_ids = params[:sub_ids]
      flash.now[:errors] = ["Must select a sub"]
      render :new
    elsif @post.update(post_params)
      @post.update_subs(params[:sub_ids])
      flash[:notice] = "#{@post.title} updated successfully"
      redirect_to post_url(@post)
    else
      @sub_ids = params[:sub_ids]
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "#{@post.title} removed successfully"
    redirect_to subs_url
  end


  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :author_id)
  end

  def ensure_author!
    @post = Post.find(params[:id])
    redirect_to post_url(@post) unless current_user == @post.author
  end
end
