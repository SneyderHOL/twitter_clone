class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows, force: true do |t|
      t.integer :follower_id, foreign_key: true
      t.integer :followee_id, foreign_key: true
      t.timestamps
    end
  end
end
