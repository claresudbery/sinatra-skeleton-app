require "sinatra"
require "erb"

# This page created as part of this tutorial: http://webapps-for-beginners.rubymonstas.org/sinatra/params.html

# To spin up this Sinatra server just run this in browser: ruby monstas_old.rb

get "/" do
    "OMG, hello Ruby Monstas!"
end

get "/param-demo-1/:name" do
    "Hello #{params["name"]}!"
end

get "/param-demo-2/:name" do
    # params.inspect will output on the page, and will look like a hash but is actually a Sinatra::IndifferentHash, 
    # which is exacly like a hash, with a small trick applied so that we can access the keys indistinctly as strings or symbols. 
    # That’s why we could use params[:name] in the previous example.
    params.inspect

    # The params hash can contain more than matches from the URL. 
    # You’ll later see that it also contains any data sent from HTML forms as part of the HTTP request. 
    # As well as any query params that can be part of the URL (separated with a question mark ?).
end

get '/monstas_old/:name' do
    # Each of the following lines is equivalent to the code below: 
    # ERB.new("<h1>Hello <%= params[:name] %></h1>").result(binding)
    # erb "<h1>Hello <%= name %></h1>", { :locals => { :name => params[:name] } }
    # erb "<h1>Hello <%= name %></h1>", { :locals => params }
    # The following three lines are equivalent to each individual line
    ##  template = "<h1>Hello <%= name %></h1>"
    ##  layout   = "<html><body><%= yield %></body></html>"
    ##  erb template, { :locals => params, :layout => layout }
    # erb :monstas, { :locals => params, :layout => :layout }
    # erb :monstas, { :locals => params, :layout => true }
    # erb :monstas, { :locals => params }
    # (The above lines were all written before name was replaced with @name in monstas.erb)
    @name = params["name"]
    erb :monstas_old

    # documentation on erb here: http://webapps-for-beginners.rubymonstas.org/sinatra/templates.html
end