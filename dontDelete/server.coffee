express = require("express")
compression = require('compression')
require("node-codein")

app = express()
http = require("http").Server(app)
io = require("socket.io")(http)

app.use(compression())
app.use(express.static(__dirname + '/dist'))

app.get "/", (req, res) -> res.sendfile "index.html"

http.listen 3000, -> console.log "listening on *:3000"

################################################

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

io.on "connection", (socket) ->
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

