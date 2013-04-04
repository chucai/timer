# encoding: utf-8
class List
	attr_accessor :items, :type

	def initialize(type = nil)
		@items = []
		@type = type || "RubyChina帖子"
	end

	class << self
		def fetch_rubychina
			list = List.new
			result_json["rubychina"].each do |node|
				item = Item.new node
				list.items << item
			end
			return list
		end

		def fetch_zhubajie
			index = 0
			list = List.new("猪八戒项目")
			result_json["zhubajie"].each do |node|
				item = Item.new(node)
				list.items << item
			end
			return list
		end

		def file_path
			@@file_path ||= File.join(File.expand_path("../..", __FILE__), "database.txt")
		end

		def result_json
			MultiJson.load(File.read(file_path))
		end

	end
end