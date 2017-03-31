class CreateOpenTokSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :open_tok_sessions do |t|
      t.string :session_id
      t.string :name

      t.timestamps
    end
  end
end
