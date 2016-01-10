class CreateWines < ActiveRecord::Migration
  def change
    create_table :wines do |t|
    	t.string :name
    	t.text :description
    	t.integer :year
    	t.string :vineyard
    	t.integer :community_rating
    end
  end
end