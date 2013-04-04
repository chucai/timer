#encoding: utf-8
require 'sinatra'
require "sinatra/reloader" if development?
require 'open-uri'
require "nokogiri"
require_relative "models/item"
require_relative "models/list"

get '/' do
	@rubychina = List.fetch_rubychina
  @zhubajie = List.fetch_zhubajie
  erb :index
end