class BookmarksController < ApplicationController

  def create
    bookmark = current_user.bookmarks.create(feed_id: params[:feed_id])
    redirect_to feeds_path, notice: "#{bookmark.feed.user.name}さんの投稿をお気に入り登録しました"
  end

  def destroy
    bookmark = current_user.bookmarks.find_by(id: params[:id]).destroy
    redirect_to feeds_path, notice: "#{bookmark.feed.user.name}さんの投稿をお気に入り解除しました"
  end
end
