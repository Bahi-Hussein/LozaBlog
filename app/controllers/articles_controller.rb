class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :like]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article }
        format.json { render :show, status: :created, location: @article }
        flash[:success] = "Article added successfully"
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article }
        format.json { render :show, status: :ok, location: @article }
        flash[:success] = "Article updated successfully"
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
      flash[:danger] = "Article deleted successfully"
    end
  end

  def like

    valid_user = @article.likes.find_by(user: current_user)

    if valid_user

      like = @article.likes.find_by(user: current_user)

      if like.like
        like.like = false
        flash[:success] = "Changed to dislike"
      elsif !like.like
        like.like = true
        flash[:success] = "Changed to like"
      end

      like.save

    else

      like = Like.create(like: params[:like], user: current_user, article: @article)
        
        if like.valid?
          flash[:success] = "Liked Successfully"
        else
          flash[:danger]= "oops!! Somthing went wrong."
        end

    end

    redirect_to :back
  end

  private
  
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body)
    end

    def require_same_user
      if current_user != @article.user
        flash[:danger] = "You can only edit your articles !!"
        redirect_to articles_path
      end
    end
end
