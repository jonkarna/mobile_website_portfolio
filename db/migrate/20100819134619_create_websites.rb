class CreateWebsites < ActiveRecord::Migration
  def self.up
    create_table :websites do |t|
      t.string :title
      t.string :image
      t.string :website
      t.string :industry
      t.string :launched
      t.string :features
      t.string :challenge
      t.string :solution

      t.timestamps
    end
  end

  def self.down
    drop_table :websites
  end
end
