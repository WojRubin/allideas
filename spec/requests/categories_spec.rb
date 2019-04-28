require "rails_helper"

describe "categories", type: :request do

  let(:categories) { create_list(:category, 5) }
  let(:parent_category) { create :category, id: 1, category_details: {"1556181010399"=>{"field_name"=>"Test", "field_type"=>"select", "field_data"=>["yes", "not"]}} }
  let(:category) { create :category, id: 2, parent_id: 1 }


  describe "categories list" do
    it "displays all categories" do
      categories
      visit "/categories"
      expect(page).to have_selector("table tr", count: 6)
    end
  end

  describe "when add new categories with parent" do
    it "have parent categories on categories list" do
      parent_category
      category
      visit "/categories"
      tr_list = page.find_all(:css, 'tr')
      tr_with_category = tr_list[2]
      expect(tr_with_category).to have_css('td.category-parent-id', text: parent_category.id )
    end

    it "have parent name when edit" do
      parent_category
      category
      visit "/categories/#{category.id}/edit"
      expect(page.find("#category_parent_id")).to have_text( parent_category.name )
    end
  end

  describe "when add new categories with parent" do
    it "have parent attributes field when edit" do
      parent_category
      visit "/categories/new"
      select "#{parent_category.name}", from: 'category_parent_id'
      fill_in "category_name", with: "Home and Garden"
      click_button("Create")
      expect(page).to have_text("category was successfully created")
    end
  end
end
