if !app? then window.app = {}
if !app.events? then app.events = {}

window.c = console; c.l = c.log
window.d = document



swDiv = $(".switchDiv")

app.events.switchImage = ->
  len = swDiv.length
  hiddenDiv = 0
  for div, i in swDiv
    if $(div).hasClass("show")
      hiddenDiv = i
      $(div).removeClass("show")
  $(swDiv[(hiddenDiv+1)%len]).addClass("show")


## init ALL
app.initApp = ->
  #ioConnect()
  for init of app.init then app.init[init](); c.l "init: "+init
  app.fs = new app.helpers.FileStorrage()

## start the app
window.onload= ->
  app.initApp()