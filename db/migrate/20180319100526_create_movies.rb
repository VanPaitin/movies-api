class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :synopsis
      t.string :thumbnail_url
      t.string :genres
      t.string :casts
      t.string :running_time
      t.datetime :release_date

      t.timestamps
    end
  end
end
