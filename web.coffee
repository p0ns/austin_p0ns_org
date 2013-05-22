    
class TheWeb    
  hostname: "localhost"
  description: "This is a small home-server somewhere in Austin, TX"
  get_uptime: ->
    @exec "uptime",(err,o,e)=>
      if o?
        @uptime = o.trim()
  get_base_data: ->
    @exec "hostname",(err,o,e)=>
      if o?
        @hostname = o.trim()
    @exec "uname -a",(err,o,e)=>
      if o?
        @uname = o.trim()
    @get_uptime()
  constructor: ()->
    @exec = require('child_process').exec
    @get_base_data()
    express = require("express")
    
    @app = express()
    
    @app.set('view engine', 'coffee')
    @app.engine 'coffee', require('coffeecup').__express
    
    @app.get '/', (req, res) =>
      # Will render views/index.coffee:
      data = 
        title: @hostname
        description: @description
      data.uname = @uname if @uname?
      data.uptime = @uptime if @uptime?
      res.render 'index', data
      
    @app.listen process.env.PORT,process.env.IP
    
    #get the uptime once a minute
    setInterval ()=>
      @get_uptime()
    , 60000
    
    console.log "The Web has begun."

this_is_the_web = new TheWeb
      

