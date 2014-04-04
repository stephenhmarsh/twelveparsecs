class CreateUserParsecVotes < ActiveRecord::Migration
  def change
    create_table :user_parsec_votes do |t|
    	t.references "user"
    	t.references "parsec"
    	t.integer "vote"
    	t.timestamp "time"
    end
  end
end
