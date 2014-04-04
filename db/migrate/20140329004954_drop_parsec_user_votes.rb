class DropParsecUserVotes < ActiveRecord::Migration
  def change
  	drop_table :parsec_user_votes
  end
end
