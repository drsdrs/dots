# if !app? then window.app = {}
# if !app.init? then app.init = {}

# img = document.getElementById("img")
# canvas = document.getElementById("canvas")
# ctx = canvas.getContext("2d")

# app.init.socketio= ->
#   socket = io.connect "http://localhost:3000"
#   socket.on "sendImage", (data)->
#     uint8Arr = new Uint8Array(data)
#     str = String.fromCharCode.apply(null, uint8Arr)
#     base64String = btoa(str)

#     img.src = "data:image/png;base64," + base64String
#     ctx.drawImage img, 0, 0
