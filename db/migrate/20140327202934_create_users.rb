class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string "name"
    	t.string "email"
    	t.string "password_digest"
    	t.integer "nerd_cred_score"
    	t.string "avatar_url"
    	t.boolean "admin"
    	t.date "date_joined"
    end
  end
end

