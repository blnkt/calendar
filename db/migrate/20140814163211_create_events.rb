class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.column :location, :string
      t.column :start_date, :timestamp
      t.column :end_date, :timestamp
    end
  end
end
