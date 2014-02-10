require 'rubygems'
require 'bundler'

Bundler.setup :default
Bundler.require :default

Rxmlspec::Validator.begin "test.xml", err_func= ->(e){ puts ({message: e}) } do
  context "/stuff" do
    permit ["a","b", "@c", "text(Herp Di Derple)"]
    expect "a" do
      permit "b" do
        permit "@c"
      end
    end
  end
end
