class CreateCategorizations < ActiveRecord::Migration
  def self.up
    create_table :categorizations do |t|
      t.references :category
      t.references :website
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :categorizations
  end
end
