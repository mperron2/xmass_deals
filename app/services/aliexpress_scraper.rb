require "open-uri"
require "nokogiri"
require "httparty"

class AliexpressScraper
  BASE_URL = "https://www.aliexpress.com/w/wholesale-"

  def self.scrape_category(category, items_count = 9)
    url = "#{BASE_URL}#{category}.html"
    response = HTTParty.get(url, headers: { "User-Agent" => "Mozilla/5.0" })

    if response.code == 200
      parse_products(response.body, items_count)
    else
      puts "Failed to fetch data for category #{category}. HTTP Status: #{response.code}"
      []
    end
  end

  private

  require "nokogiri"

  def self.parse_products(html, items_count)
    parsed_html = Nokogiri::HTML(html)
    products = []

    parsed_html.css(".multi--titleText--nXeOvyr").first(items_count).each_with_index do |title_element, index|
      name = title_element.text.strip

      name_text, description = extract_title_description(name)

      price_element = parsed_html.css(".multi--price-sale--U-S0jtj")[index]
      price = price_element ? price_element.text.strip.gsub("C$", "").to_f : nil

      image_element = parsed_html.css(".images--imageWindow--1Z-J9gn img")[index]
      next if image_element.nil?

      image_url = image_element["src"]
      image_url = "https:#{image_url}" if image_url.start_with?("//")

      products << {
        name: name_text,
        description: description,
        price: price,
        image: image_url
      }
    end

    products
  end

  def self.extract_title_description(text)
    words = text.split
    title = words[0..3].join(" ")

    description = words[4..].join(" ")
    description = description.empty? ? "No description available" : description

    [ title, description ]
  end

  def self.download_image(image_url)
    io = URI.open(image_url)
    io.class.class_eval { include ActiveStorage::Blob::Analyzable }
    io.rewind
    io
  rescue => e
    puts "Failed to download image: #{e.message}"
    nil
  end
end
