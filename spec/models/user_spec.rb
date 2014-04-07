require 'spec_helper'

describe User do 

	before(:all) do
    @test_user = User.create(name: "Test User", email: "test@example.com", nerd_cred_score: 0)
    @test_parsec = Parsec.create(title: "Test Parsec Title", body: "Test body test body test body", user_id: @test_user.id, score: 0, imdb_id: "tt0107290")
    @test_comment = Comment.create(body: "Test comment, test comment", user_id: @test_user.id, parsec_id: @test_parsec.id, score: 0)
    @test_parsec_user_vote_1 = ParsecUserVote.create(user_id: @test_user.id, parsec_id: @test_parsec.id, vote: 1) #upvote
    @test_parsec_user_vote_2 = ParsecUserVote.create(user_id: @test_user.id, parsec_id: @test_parsec.id, vote: -1) #downvote
    @test_parsec_user_vote_3 = ParsecUserVote.create(user_id: @test_user.id, parsec_id: @test_parsec.id, vote: 1) #upvote
    @test_comment_user_vote_1 = CommentUserVote.create(user_id: @test_user.id, comment_id: @test_comment.id, vote: 1) #upvote
    @test_comment_user_vote_2 = CommentUserVote.create(user_id: @test_user.id, comment_id: @test_comment.id, vote: 1) #upvote
    @test_comment_user_vote_3 = CommentUserVote.create(user_id: @test_user.id, comment_id: @test_comment.id, vote: -1) #downvote
    ## calculate scores ##
    parsec_total = 0
    @test_parsec.parsec_user_votes.each do |vote|
    	parsec_total += vote.vote
    end
    @test_parsec.score = parsec_total
    @test_parsec.save

    comment_total = 0
    @test_comment.comment_user_votes.each do |vote|
    	comment_total += vote.vote
    end
    @test_comment.score = comment_total
    @test_comment.save
  end

	it{should validate_presence_of(:name)}
	it{should validate_presence_of(:email)}

	describe 'calculate_nerd_score' do 
		it "should return accurate nerd cred score" do 
			@test_user.reload
			expect(@test_user.nerd_cred_score).to eq(0)
			@test_user.calculate_nerd_score
			@test_user.reload
			expect(@test_user.nerd_cred_score).to eq(2)
		end
	end

end