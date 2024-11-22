Product.delete_all
Category.delete_all
About.create(title: "About Us", content: "Your about us content here.")
Contact.create(title: "Contact Us", content: "Your contact us content here.")

categories = [ 'Daugther', 'Son', 'Kids', 'Mom', 'Dad', 'Couple', 'Grandma', 'Grandpa', 'Friend', 'Family', 'Pet' ]

categories.each do |category_name|
  Category.find_or_create_by!(name: category_name)
end

categories.each do |category_name|
  puts "Seeding products for category: #{category_name}"

  category = Category.find_by!(name: category_name)

  products = AliexpressScraper.scrape_category(category_name.downcase, 9)

  products.each do |product_data|
    product = Product.create!(
      name: product_data[:name],
      description: product_data[:description],
      price: product_data[:price],
      category: category
    )

    if product_data[:image]
      image_url = product_data[:image]
      io = URI.open(image_url)
      io.class.class_eval { include ActiveStorage::Blob::Analyzable }
      product.image.attach(io: io, filename: "#{product.name}.jpg", content_type: "image/jpeg")
    end
  end
end

puts "Seeding completed!"

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
