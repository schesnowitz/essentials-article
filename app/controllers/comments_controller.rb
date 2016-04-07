class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource param_method: :my_sanitizer
  load_and_authorize_resource :through => :current_user

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(params[:comment].permit(:body))
    @comment.user_id = current_user.id if current_user
    
    
    if @comment.save
      redirect_to article_path(@article), notice: "Your comment has been saved."
    else
      redirect_to 'new'
  end
end
  
  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    
    if @comment.update(params[:comment].permit(:body))
      redirect_to article_path(@article), notice: "Your comment has been updated."
    else
      render 'edit'
    end
  end
  
  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end
  
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), notice: "Your comment has been deleted."
  end
  
  
    private

  def my_sanitizer
    params.require(:comment).permit(:body)
  end


end 