class CreateWorkingDays < ActiveRecord::Migration[5.0]
  def change
    create_table :working_days do |t|
      t.datetime :checkin
      t.datetime :checkout
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
