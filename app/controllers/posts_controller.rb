class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]

  def index
    @posts = Post.all.sort_by { |x| x.total_votes }.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(strong_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "Your post was created"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(strong_params)
      flash[:notice] = "The post has been updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(vote: params[:vote], creator: current_user, voteable: @post)

    if @vote.valid?
      flash[:notice] = "Your vote was counted"
    else
      flash[:error] = "You can only vote on a post once"
    end
    
    redirect_back(fallback_location: root_path)
  end

  private

  def strong_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end
end