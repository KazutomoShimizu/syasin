class BookmarksController < ApplicationController

  def create
    bookmark = current_user.bookmarks.create(feed_id: params[:feed_id])
    redirect_to feeds_path, notice: "#{bookmark.feed.user.name}さんの投稿をお気に入り登録しました"
  end

  def destroy
    bookmark = current_user.bookmarks.find_by(id: params[:id]).destroy
    redirect_to feeds_path, notice: "#{bookmark.feed.user.name}さんの投稿をお気に入り解除しました"
  end

  def show
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:feed_id)
    @bookmark_list = Feed.find(bookmarks)
  end
end
