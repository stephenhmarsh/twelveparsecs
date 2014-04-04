class CreateParsecs < ActiveRecord::Migration
  def change
    create_table :parsecs do |t|
    	t.string "title"
    	t.text "body"
    	t.references "media"
    	t.references "user"
    	t.integer "score"
    	t.timestamp "time"
    end
  end
end
