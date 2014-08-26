express = require("express")
compression = require('compression')
require("node-codein")
require('coffee-script')

c = console; c.l = c.log

app = express()
http = require("http").Server(app)
io = require("socket.io")(http)

app.use(compression())
app.use(express.static(__dirname + '/dist'))

app.get "/", (req, res) -> res.sendfile "index.html"

app.get "/state.png", (req, res) -> res.sendfile "state.png"

http.listen 3000, -> console.log "listening on *:3000"

################################################


imageURL = require("./server/canvas")
#c.l a

users = {}
userCount = 0
mapSize = 256

posExists = (pos)->
  for user of users
    if users[user].pos.x is pos.x
      newPos =
        x: Math.floor(Math.random()*mapSize)
        y: Math.floor(Math.random()*mapSize)
      console.log "newPos is ",pos
      return posExists(newPos)
  pos

API = require("./server/canvas").API
io.on "connection", (socket) ->


  setInterval ->
    rndA = Math.random()*255
    rndB = Math.random()*255
    rndC = Math.random()*255
    API.drawCircle(rndA+0,rndB+0,rndC/32,"rgba("+(~~rndA^rndC)+","+(~~rndB^rndC)+","+(~~rndC^rndB^rndA)+",0.7)")
    socket.emit "sendImage", API.getImage()
  ,25



  socket.on "login", (name)->
    socket.name = name
    userCount++
    while users[name]? then name+="@"
    halfMap = Math.floor(mapSize/2)
    pos = posExists x:halfMap, y:halfMap
    users[name] = pos: pos
    console.log name, mapSize, pos.x, pos.y, users
    socket.emit "login", name, mapSize, pos.x, pos.y

  socket.on "click", (name)-> console.log "click # "+name

  socket.on "rePos", (name, x, y)-> users[name].pos= x:x, y:y

  socket.on "disconnect", (e)->
    userCount--
    delete users[socket.name]
    console.log "user #{socket.name} disconnected"

