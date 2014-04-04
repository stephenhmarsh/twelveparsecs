class RenameUserParsecVotesToParsecUserVotes < ActiveRecord::Migration
  def change
  	rename_table :user_parsec_votes, :parsec_user_votes
  end
end
