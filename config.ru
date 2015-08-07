class Hello 
  def self.call(env)
  	[200, # 200 indicates success
  	 {"Content-Type" => "text/plain"}, # hash of headers
  	 ["Hello from Rack!"] # we wrap body in an array so it responds to 'each'
  	]
  end
end

# tell rack what to run our app
run Hello
