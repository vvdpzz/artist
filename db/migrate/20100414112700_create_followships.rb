class CreateFollowships < ActiveRecord::Migration
  def self.up
    create_table :followships do |t|
      t.references :user
      t.integer :followeduser_id

      t.timestamps
    end
  end

  def self.down
    drop_table :followships
  end
end
