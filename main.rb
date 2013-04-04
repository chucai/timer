#encoding: utf-8
require 'open-uri'
require "nokogiri"
require 'pry'

def fetch_rubychina
	website = "http://ruby-china.org/topics/node25"
	doc = Nokogiri::HTML(open(website))
	root = "http://ruby-china.org"
	doc.css(".infos").each do |div|
		puts "项目名称: " + div.search(".title>a").first.text
		puts "项目地址: " + root + div.search(".title>a").first.attributes["href"].value
		puts "回复时间: " + div.search(".timeago").first.attributes["title"].value
		puts "*"*30
	end
end

fetch_rubychina

def fetch_zhubajie
	website = "http://search.zhubajie.com/main/all?kw=ruby"
	doc = Nokogiri::HTML(open(website))
	# doc.xpath("//p[@class='name-tit']/a[@class='.tit']").each do |link|
	# 	puts link.text
	# end

	index = 0
	doc.css("#userlist dl.user-information").each do |dl|
		dd = dl.search("dd").first
		dd_mint = dl.search("dd.mint").first
		# binding.pry
		p = dd.search("p.name-tit").first
		next if p.nil?
		u = p.search("u")
		next if u.empty?
		node = p.children.css("a.tit").last
		# binding.pry
		index = index + 1
		puts "项目序列号: #{index}" 
		puts u.text
		puts "项目名称: " + node.text
		puts "发布时间: " + dd_mint.search("a.time").first.text
		puts "项目价钱: " + dd.search("p.sum i").first.text
		puts "项目地址: " + node.attributes["href"].value
		puts "*"*30
	end
end
