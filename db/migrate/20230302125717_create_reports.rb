class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :reporter_id, null: false #通報したユーザー
      t.integer :reported_id, null: false #通報されたユーザー
      t.text :reason, null: false #通報理由
      t.text :url #悪質な投稿等のURLがあれば貼ってもらう為
      t.integer :status, default: 0, null: false #管理者が通報に対して「対応済み」等、ステータスを変えられるようにする。
      t.timestamps
    end
  end
end
