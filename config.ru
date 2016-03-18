# https://github.com/rack/rack/wiki/%28tutorial%29-rackup-howto

require 'rubygems'
require 'bundler'


require File.join(File.dirname(__FILE__), 'admin_interface.rb')

run AdminInterface
