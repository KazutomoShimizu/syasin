class AddFeedToBody < ActiveRecord::Migration[6.0]
  def change
    add_column :feeds, :body, :text
  end
end
