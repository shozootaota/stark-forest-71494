class CommentsController < ApplicationController
    def index
        article = Article.find(params[:article_id])
        @comment = article.comments.build
        @comments = article.comments
    end

    def new
        article = Article.find(params[:article_id])
        @comment = article.comments.build
    end

    def create
        article = Article.find(params[:article_id])
        @comment = article.comments.build(comment_params)
        if @comment.save
            redirect_to article_comments_path(article), notice: 'コメントを追加'
        else
            flash.now[:error] = '更新できませんでした'
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end
