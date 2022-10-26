class CommentsController < ApplicationController
    def index
        article = Article.find(params[:article_id])
        @comment = article.comments.build
    end

    def new
        article = Article.find(params[:article_id])
        @comment = article.comments.build
    end

    def create
        article = Article.find(params[:article_id])
        @comment = article.comments.build(comment_params)
        @comment.user_id  = current_user.id
        if @comment.save
            redirect_to article_path(article), notice: 'コメントを追加'
        else
            flash.now[:error] = '投稿できませんでした'
            render :new
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:content)
    end
end
