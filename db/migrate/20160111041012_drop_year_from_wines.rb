class DropYearFromWines < ActiveRecord::Migration
	def down
    remove_column :wines, :year
  end
end
