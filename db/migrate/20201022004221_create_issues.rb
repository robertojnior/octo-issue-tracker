class CreateIssues < ActiveRecord::Migration[6.0]
  def change
    create_table :issues do |t|
      t.integer :number, null: false

      t.string :title, null: false
      t.string :body

      t.index :number, unique: true

      t.timestamps
    end
  end
end
