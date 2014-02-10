require 'rubygems'
require 'bundler'

Bundler.setup :default
Bundler.require :default

Rxmlspec::Validator.validate "test.xml" do
  context "/stuff" do
    permit ["a","b"]
    expect "a" do
      permit "b" do
        permit "@c"
      end
    end
  end
end
