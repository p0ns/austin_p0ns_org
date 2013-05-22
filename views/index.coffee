doctype 5
html ->
  head ->
    meta charset: 'utf-8'
    title "#{@title or 'localhost'}"
    meta(name: 'description', content: @description) if @description?


    style '''
      body {text-align: center; font-family: sans-serif}
      header, nav, section, footer {display: block}
    '''


    script src: 'http://code.jquery.com/jquery-1.9.1.min.js'

   
  body ->
    header ->
      h1 @title or 'localhost'
    
    div ->
      h3 @description 
      h5 @uname if @uname? and @uname isnt "" 
      h5 @uptime if @uptime?

    footer ->
      # CoffeeScript comments. Not visible in the output document.
      