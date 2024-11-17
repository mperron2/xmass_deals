require "nokogiri"
require "httparty"

class AliexpressScraper
  BASE_URL = "https://www.aliexpress.com/gcp/300000444/6NcN22X5fS?spm=a2g0o.home.superdeal.1.650c76dbjyR3MF&disableNav=YES&pha_manifest=ssr&_immersiveMode=true"

  def self.scrape_products(keyword)
    query = keyword.gsub(" ", "+")
    url = "#{BASE_URL}?SearchText=#{query}"

    response = HTTParty.get(url, headers: { "User-Agent" => "Mozilla/5.0" })

    if response.code == 200
      parse_products(response.body)
    else
      puts "Failed to fetch data. HTTP Status: #{response.code}"
      []
    end
  end

  private

  def self.parse_products(html)
    document = Nokogiri::HTML(html)

    products = []
    document.css(".manhattan-card-container").each do |card|
      product = {
        name: card.css(".product-title").text.strip,
        price: card.css(".price-current").text.strip,
        link: card.at_css("a")&.[]("href"),
        image: card.at_css("img")&.[]("src")
      }
      products << product
    end
    products
  end
end
