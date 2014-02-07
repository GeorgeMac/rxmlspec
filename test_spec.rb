require './lib/ruby-xmlspec.rb'

xmlspec "test.xml" do
  context "/stuff" do
    permit ["a","b"]
    expect "a" do
      permit "b" do
        permit "@c"
      end
    end
  end
end
