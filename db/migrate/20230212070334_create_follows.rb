class CreateFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :follows do |t|
      t.integer :follower_id #フォローするユーザのid
      t.integer :followed_id #フォローされるユーザのid
      t.timestamps
    end
  end
end
