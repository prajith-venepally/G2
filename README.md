# User profiling
API only web application.

## models
* category
* subcategory(belongs to category)
* product(belongs to subcategory) -- Every product has internal score. Which will be updated for every feedback.
* user
* search(belongs to user and product or subcategory)
* feedback(belongs to user and product)
* bookmark(belongs to user and product)

Test data is located at db/seeds.rb.
```
rake db:seed
```
First time users should make api call with persona to get feed. Products will be displayed based on internal score.
``` 
users/get_feed?email=test@gmail.com&persona=development
```
To give feedback make a post call to
``` 
/feedbacks
body {"email":"test@gmail.com", "product":"Eclipse", "rating":4, "description":"Easy to use"}
```
Users can search for products or subcategory. 
```
/products/search?sub_category=Testing&email=test@gmail.com
/products/search?product=Eclipse&email=test@gmail.com
```
Users can bookmark the product.
```
/bookmarks
body {"email":"test@gmail.com", "product":"Eclipse"}
```
Non first time users can get feed by 
``` 
users/get_feed?email=test@gmail.com
```
For every user feedback, search, bookmark user feed will get updated.
Things considered to generate feed.
* Bookmarked products should be on top.
* Positive feedback(for simplicity rating above 3 considered as positive feedback) products should be on top. User might not be interested in other products in that category.
* Negative feedback products should be at bottom. User might be interested in other products in that category.
* Searched products should be on top.
* All products in searched sub category should be on top.

check ``` users_controller#get_feed ``` and ```feedbacks_controller#update_product_score``` for more information.
