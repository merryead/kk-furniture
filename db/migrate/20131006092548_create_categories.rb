class CreateCategories < ActiveRecord::Migration
  def up
  	create_table :categories do |t|
  		t.string	:name
  		t.text		:description
  		t.timestamps
  	end
  end

  def down
  end
end