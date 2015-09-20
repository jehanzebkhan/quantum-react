# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
p "Removing #{Tag.count} Tags"
Tag.destroy_all
p "Removing #{Product.count} Products"
Product.destroy_all

["Bread", "Butter", "Bakery", "Breakfast", "Soft Drink",
  "Meat", "Chicken", "Beef", "Fish", "Juice"].each do | tag |
    Tag.create label: tag
  end
p "Tags Created: #{Tag.count}"

product_hash = {
  "Helga" => "Bread,Bakery,Breakfast",
  "Steggles Chicken" => "Chicken,Meat",
  "Ocean Samon" => "Fish",
  "Tuna" => "Fish",
  "Sun Ripe Mango Juice" => "Juice,Breakfast",
  "Steak" => "Beef"
}

product_hash.keys.each do | title |
  product = Product.create title: title
  product_hash[title].split(",").each do | tag_label |
    tag = Tag.find_by(label: tag_label)
    product.tags << tag
  end
  product.save!
end
p "Products Created: #{Product.count}"
