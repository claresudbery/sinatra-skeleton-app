require "sinatra"
require "erb"

# This page created as part of this tutorial: http://webapps-for-beginners.rubymonstas.org/sinatra/params.html

# To spin up this Sinatra server just run this in browser: ruby monstas.rb

enable :sessions

def store_name(filename, string)
    File.open(filename, "a+") do |file|
        file.puts(string)
    end
end

def read_names
    return [] unless File.exist?("names.txt")
    File.read("names.txt").split("\n")
end

class NameValidator    
    def initialize(name, names)
    @name = name.to_s
    @names = names
    end

    def valid?
    validate
    @message.nil?
    end

    def message
    @message
    end

    private

    def validate
        if @name.empty?
        @message = "You need to enter a name."
        elsif @names.include?(@name)
        @message = "#{@name} is already included in our list."
        end
    end
end

get '/' do
    "Hello World #{params[:name]}".strip
end

get "/monstas" do
    @message = session.delete(:message)
    @name = params["name"]
    @names = read_names
    erb :monstas
end

post "/monstas" do
    @name = params["name"]
    @names = read_names
    validator = NameValidator.new(@name, @names)

    if validator.valid?
        store_name("names.txt", @name)
        session[:message] = "Successfully stored the name #{@name}."
        redirect "/monstas?name=#{@name}"
    else
        @message = validator.message
        erb :monstas
    end
end