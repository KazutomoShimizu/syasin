class FeedsController < ApplicationController
  before_action :set_feed, only: %i[ show edit update destroy ]
  before_action :baria_user, only: [:edit, :destroy, :update]

  def confirm
    @feed = Feed.new(feed_params)
  end

  def index
    @feeds = Feed.all
  end

  def show
    @feed = Feed.find_by(id:params[:id])
    @user = User.find_by(id:@feed.user_id)
    @bookmark = current_user.bookmarks.find_by(feed_id: @feed.id)
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def edit
    @feed = Feed.find(params[:id])
    if @feed.user == current_user
      render "edit"
    else
      redirect_to feeds_path
    end
  end

  def create
    @feed = current_user.feeds.build(feed_params)
    respond_to do |format|
      if @feed.save
        CompleteFeedMailer.complete_mail(current_user).deliver_later
        format.html { redirect_to feed_url(@feed), notice: "Feed was successfully created." }
        format.json { render :show, status: :created, location: @feed }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to feed_url(@feed), notice: "Feed was successfully updated." }
        format.json { render :show, status: :ok, location: @feed }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_url, notice: "Feed was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:content, :image, :image_cache, :body)
  end

  def baria_user
    unless Feed.find(params[:id]).user.id.to_i == current_user.id
      edirect_to feeds_path(current_user)
    end
  end
end
