require "sinatra"
require "erb"

# This page created as part of this tutorial: http://webapps-for-beginners.rubymonstas.org/sinatra/params.html

# To spin up this Sinatra server just run this in browser: ruby monstas.rb

def store_name(filename, string)
    File.open(filename, "a+") do |file|
        file.puts(string)
    end
end

get "/monstas" do
    @name = params["name"]
    store_name("names.txt", @name)
    erb :monstas
end