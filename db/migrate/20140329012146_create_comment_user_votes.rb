class CreateCommentUserVotes < ActiveRecord::Migration
  def change
    create_table :comment_user_votes do |t|
    	t.references "user"
    	t.references "comment"
    	t.integer "vote"
    	t.timestamp "time"
    end
  end
end
