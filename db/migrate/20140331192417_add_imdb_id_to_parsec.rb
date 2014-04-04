class AddImdbIdToParsec < ActiveRecord::Migration
  def change
  	  add_column :parsecs, :imdb_id, :string
  end
end
