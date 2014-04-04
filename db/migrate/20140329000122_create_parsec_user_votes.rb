class CreateParsecUserVotes < ActiveRecord::Migration
  def change
    create_table :parsec_user_votes do |t|
    	t.references "user"
    	t.references "parsec"
    	t.integer "vote"
    	t.timestamp "time"
    end
  end
end
