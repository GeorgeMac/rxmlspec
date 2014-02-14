require 'rubygems'
require 'bundler'

Bundler.setup :default
Bundler.require :default

Rxmlspec::Validator.begin "test.xml", err_func= ->(e){ puts "Invalid condition reason: #{e[:reason]} type: #{e[:type]} name: #{e[:name]}" } do
  context "/stuff" do
    expect("a","c") do
      expect "b" do
        permit "@c"
      end
    end
  end
end
