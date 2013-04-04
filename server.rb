#encoding: utf-8
require 'sinatra'
require "sinatra/reloader"
require 'open-uri'
require "nokogiri"
require_relative "models/item"
require_relative "models/list"

require 'pry'

get '/' do
	@items = List.fetch_zhubajie
  erb :index
end