if !app? then window.app = {}
if !app.init? then app.init = {}
if !app.events? then app.events = {}

######\ \######
#  Jcr/ /op   #
######\ \#####

seqImg = $("#seqCut")
seqImg[0].src = "images/0.jpg"
waveImg = $("#waveCut")
waveImg[0].src = "images/0.jpg"
wavemodImg = $("#wavemodCut")
wavemodImg[0].src = "images/0.jpg"

canvasWave = document.getElementById("canvasWave")
canvasWavemod = document.getElementById("canvasWavemod")
canvasSeq = document.getElementById("canvasSeq")

contextWave = canvasWave.getContext("2d")
contextWavemod = canvasWavemod.getContext("2d")
contextSeq = canvasSeq.getContext("2d")

jcrop_api = {}

app.init.jcrop = ->

  cutWaveImg = (c, e)->
    img = $(".jcrop-holder .waveCut")[0]
    canvasWave.width = c.w
    canvasWave.height = c.h
    contextWave.drawImage img, c.x, c.y, c.w, c.h, 0, 0, c.w, c.h

  cutWavemodImg = (c, e)->
    img = $(".jcrop-holder .wavemodCut")[0]
    canvasWavemod.width = c.w
    canvasWavemod.height = c.h
    contextWavemod.drawImage img, c.x, c.y, c.w, c.h, 0, 0, c.w, c.h

  cutSeqImg = (c, e)->
    img = $(".jcrop-holder .seqCut")[0]
    canvasSeq.width = c.w
    canvasSeq.height = c.h
    contextSeq.drawImage img, c.x, c.y, c.w, c.h, 0, 0, c.w, c.h

  waveImg.Jcrop
    onSelect: cutWaveImg
    onChange: cutWaveImg
    boxWidth: window.innerWidth
  , ->
    jcrop_api["waveImage"] = @
    @animateTo [
      0, 0, 400, 300
    ]
  wavemodImg.Jcrop
    onSelect: cutWavemodImg
    onChange: cutWavemodImg
    boxWidth: window.innerWidth
  , ->
    jcrop_api["wavemodImage"] = @
    @animateTo [
      0, 0, 400, 300
    ], -> c.l @
  seqImg.Jcrop
    onSelect: cutSeqImg
    onChange: cutSeqImg
    boxWidth: window.innerWidth
  , ->
    jcrop_api["seqImage"] = @
    @animateTo [120, 120, 600, 700]
  app.jj = jcrop_api

app.events.loadImgIntoActive = (e)->
  imgSrc = e.target.src
  imgTarget = $(".switchDiv.show")
  id = imgTarget[0].id
  jcrop_api[id].disable()
  jcrop_api[id].setImage imgSrc
  jcrop_api[id].enable()
  setTimeout (->e.target.className = ""),0