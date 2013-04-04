class List
	class << self
		def fetch_rubychina
			website = "http://ruby-china.org/topics/node25"
			doc = Nokogiri::HTML(open(website))
			root = "http://ruby-china.org"
			items = []
			doc.css(".infos").each do |div|
				item = Item.new
				item.name = div.search(".title>a").first.text
				item.site = root + div.search(".title>a").first.attributes["href"].value
				item.time = div.search(".timeago").first.attributes["title"].value
				items << item
			end
			return items
		end

		def fetch_zhubajie
			website = "http://search.zhubajie.com/main/all?kw=ruby"
			doc = Nokogiri::HTML(open(website))
			index = 0
			items = []
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
				items << item
			end
			return items
		end
	end
end