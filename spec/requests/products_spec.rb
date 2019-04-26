require "rails_helper"

describe "products", type: :request do

	let(:categories) { create_list( :category,5) }
	let(:products) { create_list( :product, 5) }
	let(:first_product) { create :product, category_id: categories[1].id }
	let(:second_product) { create :product, category_id: (categories[2].id) }
	

	describe "products request" do
	  describe "products list" do
	    it "displays all products" do
	    	products
	      visit "/products"
	      expect(page).to have_selector("table tr", count: 6)
	    end
	  end

	  describe "search form" do
	    it "displays only searched products" do
	    	categories
	    	first_product
	    	second_product
	      visit "/products"
	      select "#{categories[1].name}", from: 'category_id'
	      click_button("Search")
	      expect(page).to have_selector("table tr", count: 2)
	    end
	  end
	end
end

