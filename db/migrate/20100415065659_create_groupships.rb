class CreateGroupships < ActiveRecord::Migration
  def self.up
    create_table :groupships do |t|
      t.references :user
      t.references :group

      t.timestamps
    end
  end

  def self.down
    drop_table :groupships
  end
end
