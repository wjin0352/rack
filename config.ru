class ToUpper
	# the class will be initialized with another rack app
	def initialize(app)
		@app = app 
	end

	def call(env)
		# first, call 'app'
		status, headers, body = @app.call(env)

		# iterate through body, upcasing each chunk
		upcased_body = body.map { |chunk| chunk.upcase }

		# pass our new body on through
		[status, headers, upcased_body]
	end

	# def call(env)
	# 	req = Rack::Request.new(env)
	# 	req.request_method # => GET, POST, PUT, etc
	# 	req.get?					 # is this a GET request?
	# 	req.path_info 		 # the path this request came from
	# 	req.session				 # access to session object, if using the # Rack::Session middleware
	# 	req.params 				 # a hash of merged GET and POST params, useful for getting balues out of query string

	# 	# tons more of these out there... 
	# end

end

class Hello 
  def self.call(env)
  	[200, # 200 indicates success
  	 {"Content-Type" => "text/plain"}, # hash of headers
  	 ["Hello from Rack!"] # we wrap body in an array so it responds to 'each'
  	]
  end

  # def self.call(env)
  # 	res = Rack::Response.new

  # 	# this will automatically set content-length header for you
  # 	res.write "Hello from Rack!"

  # 	# returns standard [status,headers,body] array
  # 	res.finish
  # 	# You can get/set headers with square bracket syntax:
  #   #   res["Content-Type"] = "text/plain"
 
  #   # You can set and delete cookies
  #   #   res.set_cookie("user_id", 1)
  #   #   res.delete_cookie("user_id")
  # end



end

use ToUpper # tell rack to use our new middleware

# tell rack what to run our app
run Hello


# What Rack did here was build a Rack application that was the composition of the ToUpper and Hello applications. Internal to Rack, there's a Builder class that effectively constructed a new app by doing the equivalent of:

# app = ToUpper.new(Hello)
# run app

# use Middleware1
# use Middleware2
# use Middleware3
# run MyApp
 
#=> Boils down to Middleware1.new(Middleware2.new(Middleware3.new(MyApp)))













