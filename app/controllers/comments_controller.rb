class CommentsController < ApplicationController
  def new
    @comment = Comment.new(
      post_id: params[:post_id],
      parent_comment_id: params[:parent_comment_id]
    )
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    (@comment.parent_comment_id = params[:parent_comment_id])
    if @comment.save
      flash[:notice] = "Comment added successfully"
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment removed successfully"
    redirect_to post_url(@comment.post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
