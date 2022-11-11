class CommentsController < ApplicationController
  def article
    @article = Article.find(params[:article_id])
  end

  def comment
    @comment = article.comments.find(params[:id])
  end

  def new
    @comment = article.comments.new
  end

  def create
    @comment = article.comments.create(comment_params)
    redirect_to article_path(article)
  end

  def edit
    comment
  end

  def update
    if comment.update(comment_params)
      redirect_to article
    else
      render :edit
    end
  end

  def destroy
    comment.destroy

    redirect_to article_path(article)
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end
