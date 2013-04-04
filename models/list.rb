# encoding: utf-8
class List
	attr_accessor :items, :type

	def initialize(type = nil)
		@items = []
		@type = type || "RubyChina帖子"
	end

	class << self
		def fetch_rubychina
			website = "http://ruby-china.org/topics/node25"
			doc = Nokogiri::HTML(open(website))
			root = "http://ruby-china.org"
			list = List.new
			doc.css(".infos").each do |div|
				item = Item.new
				item.name = div.search(".title>a").first.text
				item.site = root + div.search(".title>a").first.attributes["href"].value
				item.time = div.search(".timeago").first.attributes["title"].value
				list.items << item
			end
			return list
		end

		def fetch_zhubajie
			website = "http://search.zhubajie.com/main/all?kw=ruby"
			doc = Nokogiri::HTML(open(website))
			index = 0
			list = List.new("猪八戒项目")
			doc.css("#userlist dl.user-information").each do |dl|
				dd = dl.search("dd").first
				dd_mint = dl.search("dd.mint").first
				p = dd.search("p.name-tit").first
				next if p.nil?
				u = p.search("u")
				next if u.empty?
				node = p.children.css("a.tit").last
				index = index + 1
				item = Item.new
				item.number = index
				item.type = u.text
				item.name =  node.text
				item.time = dd_mint.search("a.time").first.text
				item.money = dd.search("p.sum i").first.text
				item.site = node.attributes["href"].value
				list.items << item
			end
			return list
		end
	end
end