require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def scrape_in_ear
        doc = Nokogiri::HTML(open("https://www.cnet.com/topics/headphones/best-headphones/earbuds/")).css("#rbContent div.bestListing ul li div.itemWrap")

        in_ear_array =[]

        doc.each do |headphone|
          h_name = headphone.css("h5").text
          h_price = headphone.css(".price")
          h_url = "https://www.cnet.com#{doc.css(".review").attribute("href").value}"
          h_rating = headphone[1].css(".subrating").attribute("aria-lable").value

          in_ear_array << {name: h_name, price: h_price, url: h_url, rating: h_rating}

          binding.pry
        end
        in_ear_array
      end
  # def self.scrape_index_page(index_url)
  #
  #   doc = Nokogiri::HTML(open(index_url)).css(".roster-cards-container")
  #
  #   students = doc.collect do |s|
  #     s.css(".student-card").collect do |s|
  #       {:name => s.css("h4").text,
  #        :location => s.css("p").text,
  #        :profile_url => s.css("a").attr("href").value
  #      }
  #     end
  #   end
  #   students.flatten
  # end

  def self.scrape_profile_page(profile_url)

    doc = Nokogiri::HTML(open(profile_url)).css("body")
    social = doc.css(".social-icon-container").css("a")
    student_profile = {}

    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css("div.description-holder p").text

      social.each do |link|
        if link.attr("href").include?("twitter")
          student_profile[:twitter] = link.attr("href")
        elsif link.attr("href").include?("linkedin")
          student_profile[:linkedin] = link.attr("href")
        elsif link.attr("href").include?("github")
          student_profile[:github] = link.attr("href")
        else
          student_profile[:blog] = link.attr("href")
        end
      end
      student_profile
  end

end
