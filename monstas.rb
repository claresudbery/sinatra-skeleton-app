require "sinatra"
require "erb"

enable :sessions

# This page created as part of this tutorial: http://webapps-for-beginners.rubymonstas.org/sinatra/params.html

# To spin up this Sinatra server just run this in browser: ruby monstas.rb

def store_name(filename, string)
    File.open(filename, "a+") do |file|
        file.puts(string)
    end
end

def read_names
    return [] unless File.exist?("names.txt")
    File.read("names.txt").split("\n")
end

get "/monstas" do
    @message = session.delete(:message)
    @name = params["name"]
    @names = read_names
    erb :monstas
end

post "/monstas" do
    @name = params["name"]
    store_name("names.txt", @name)
    session[:message] = "Successfully stored the name #{@name}."
    redirect "/monstas?name=#{@name}"
end