class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.references :issue, null: false, foreign_key: true

      t.string :action, null: false, limit: 12

      t.datetime :issued_on, null: false

      t.timestamps
    end
  end
end
