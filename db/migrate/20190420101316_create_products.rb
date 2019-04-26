class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
    	t.references :category, index: true, foreign_key: true
    	t.string :name, index: true
    	t.jsonb :product_details, null: false, default: '{}'
    end
  end
end
