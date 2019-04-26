module CategoriesHelper

	def siblings parent
		Category.siblings(parent)
	end
end
