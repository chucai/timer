#encoding: utf-8
require 'sinatra'
require "sinatra/reloader" #if development?
require 'open-uri'
require "nokogiri"
require "multi_json"

require_relative "models/item"
require_relative "models/list"

get '/' do
  @lasttime = File.mtime(List.file_path).strftime("%Y-%m-%d %H:%M")
	@rubychina = List.fetch_rubychina
  @zhubajie = List.fetch_zhubajie
  erb :index
end