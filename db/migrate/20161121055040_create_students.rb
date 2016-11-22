class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :regid
      t.string :dept
      t.integer :maths
      t.integer :physics
      t.integer :chemistry
      t.integer :year
      t.references :colleges

      t.timestamps
    end
    add_index :students, :colleges_id
  end
end
