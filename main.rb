#encoding: utf-8
require 'open-uri'
require "nokogiri"
require "multi_json"
require 'pry'

@hash = {}
def fetch_rubychina
	website = "http://ruby-china.org/topics/node25"
	doc = Nokogiri::HTML(open(website))
	root = "http://ruby-china.org"
	results = []
	doc.css(".infos").each do |div|
		item = {}
		item[:name] = div.search(".title>a").first.text
		item[:site] = root + div.search(".title>a").first.attributes["href"].value
		item[:time] = div.search(".timeago").first.attributes["title"].value
		results << item
	end
	@hash.merge!({"rubychina" => results})
end


def fetch_zhubajie
	website = "http://search.zhubajie.com/main/all?kw=ruby"
	doc = Nokogiri::HTML(open(website))
	index = 0
	results = []
	doc.css("#userlist dl.user-information").each do |dl|
		dd = dl.search("dd").first
		dd_mint = dl.search("dd.mint").first
		p = dd.search("p.name-tit").first
		next if p.nil?
		u = p.search("u")
		next if u.empty?
		node = p.children.css("a.tit").last
		index = index + 1

		item = {}
		item[:number] = index
		item[:type] = u.text
		item[:name] = node.text
		item[:money] = dd.search("p.sum i").first.text
		item[:time] = dd_mint.search("a.time").first.text
		item[:site] = node.attributes["href"].value

		results << item
	end
	@hash.merge!({"zhubajie" => results})
end


def run
  fetch_rubychina
  fetch_zhubajie
  result = MultiJson.dump(@hash,  :pretty => true)
  File.open("database.txt", "w") do |f|
  	f << result
	end

end

run