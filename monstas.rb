require "sinatra/base"
require "erb"

# This page created as part of this tutorial: http://webapps-for-beginners.rubymonstas.org/sinatra/params.html

# To start the app / spin up the server, run the following on the command line: rackup -p 4567
# Alternatively you can still just use: ruby monstas.rb

class MyApp < Sinatra::Base
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

    # Visit http://127.0.0.1:4567 in the browser
    get '/' do
        "Hello World #{params[:name]}".strip
    end

    # Visit http://127.0.0.1:4567/monstas in the browser 
    get "/monstas" do
        @message = session.delete(:message)
        @name = params["name"]
        @names = read_names
        erb :monstas
    end

    # Visit http://127.0.0.1:4567/monstas in the browser and enter a name
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

    run! if app_file == $0
end