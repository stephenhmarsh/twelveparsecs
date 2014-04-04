class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.references "user"
    	t.references "parsec"
    	t.text "body"
    	t.timestamp "time"
    	t.integer "score"
    end
  end
end
