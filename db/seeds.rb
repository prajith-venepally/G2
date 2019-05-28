Feedback.destroy_all
Search.destroy_all
Bookmark.destroy_all
Category.destroy_all
SubCategory.destroy_all
Product.destroy_all
User.destroy_all


development = Category.create(name: "development")
sub_categories = [
{name: "IDE"}, 
{name: "Version Control"}, 
{name: "Testing"}, 
{name: "Bug Tracking"}, 
{name: "Text Editor"}
]
products = [
{name: "Eclipse", internal_score: 3, sub_category: "IDE"}, 
{name: "RubyMine", internal_score: 3, sub_category: "IDE"},
{name: "Visual Studio", internal_score: 3, sub_category: "IDE"},
{name: "Komodo", internal_score: 3, sub_category: "IDE"},
{name: "Xcode", internal_score: 3, sub_category: "IDE"},
{name: "Git", internal_score: 3, sub_category: "Version Control"},
{name: "BitBucket", internal_score: 3, sub_category: "Version Control"},
{name: "SVN", internal_score: 3, sub_category: "Version Control"},
{name: "Browserstack", internal_score: 3, sub_category: "Testing"},
{name: "Zephyr", internal_score: 3, sub_category: "Testing"},
{name: "TestComplete", internal_score: 3, sub_category: "Testing"},
{name: "UserTesting", internal_score: 3, sub_category: "Testing"},
{name: "test IO", internal_score: 3, sub_category: "Testing"},
{name: "Jira", internal_score: 3, sub_category: "Bug Tracking"},
{name: "BugZilla", internal_score: 3, sub_category: "Bug Tracking"},
{name: "Bugly", internal_score: 3, sub_category: "Bug Tracking"},
{name: "Trac", internal_score: 3, sub_category: "Bug Tracking"},
{name: "Bugzero", internal_score: 3, sub_category: "Bug Tracking"},
{name: "Sublime", internal_score: 3, sub_category: "Text Editor"},
{name: "Notepad++", internal_score: 3, sub_category: "Text Editor"},
{name: "Brackets", internal_score: 3, sub_category: "Text Editor"},
{name: "TextEdit", internal_score: 3, sub_category: "Text Editor"},
{name: "TextPad", internal_score: 3, sub_category: "Text Editor"}
]

sub_categories.each do |sub_category|
	sub_category = SubCategory.create(sub_category)
	development.sub_categories << sub_category
	products.each do |product|
		if(product.slice(:sub_category)[:sub_category] == sub_category.name)
			product = Product.create(product.except(:sub_category))
			sub_category.products << product
		end
	end
end
