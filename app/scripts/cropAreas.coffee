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
  waveImgPos = [200, 200, 300, 300]
  wavemodImgPos = [200, 200, 300, 300]
  seqImgPos = [200, 200, 300, 300]

  cutWaveImg = (c, e)->
    img = $(".jcrop-holder .waveCut")[0]
    jcrop_api["waveImage"].pos = [c.x, c.y, c.x2, c.y2]
    canvasWave.width = c.w
    canvasWave.height = c.h
    contextWave.drawImage img, c.x, c.y, c.w, c.h, 0, 0, c.w, c.h

  cutWavemodImg = (c, e)->
    img = $(".jcrop-holder .wavemodCut")[0]
    jcrop_api["wavemodImage"].pos = [c.x, c.y, c.x2, c.y2]
    canvasWavemod.width = c.w
    canvasWavemod.height = c.h
    contextWavemod.drawImage img, c.x, c.y, c.w, c.h, 0, 0, c.w, c.h

  cutSeqImg = (c, e)->
    img = $(".jcrop-holder .seqCut")[0]
    jcrop_api["seqImage"].pos = [c.x, c.y, c.x2, c.y2]
    canvasSeq.width = c.w
    canvasSeq.height = c.h
    contextSeq.drawImage img, c.x, c.y, c.w, c.h, 0, 0, c.w, c.h

  waveImg.Jcrop
    #onSelect: cutWaveImg
    onChange: cutWaveImg
    boxWidth: window.innerWidth
  , ->
    jcrop_api["waveImage"] = @
    @animateTo waveImgPos

  wavemodImg.Jcrop
    #onSelect: cutWavemodImg
    onChange: cutWavemodImg
    boxWidth: window.innerWidth
  , ->
    jcrop_api["wavemodImage"] = @
    @animateTo wavemodImgPos

  seqImg.Jcrop
    #onSelect: cutSeqImg
    onChange: cutSeqImg
    boxWidth: window.innerWidth
  , ->
    jcrop_api["seqImage"] = @
    @animateTo seqImgPos

  app.jj = jcrop_api

app.events.loadImgIntoActive = (e)->
  imgSrc = e.target.src
  id = $(".switchDiv.show")[0].id
  jcrop_api[id].disable()
  jcrop_api[id].setImage imgSrc
  jcrop_api[id].enable()
  setTimeout (->e.target.className = ""),0

app.events.getRandomImg = (e)->
  imgs = $("#imageList img")
  rndNum = ~~(Math.random()*imgs.length)
  e=
    target:
      src:
        imgs[rndNum].src
  app.events.loadImgIntoActive(e)

moveSelTo = (posMod)->
  id = $(".switchDiv.show")[0].id
  pos = jcrop_api[id].pos
  for p, i in pos then pos[i] += posMod[i]
  jcrop_api[id].animateTo pos

app.events.selUp = (e)-> moveSelTo [0, 50, 0, 50]
app.events.selDown = (e)-> moveSelTo [0, -50, 0, -50]
app.events.selRight = (e)-> moveSelTo [50, 0, 50, 0]
app.events.selLeft = (e)-> moveSelTo [-50, 0, -50, 0]

app.events.expandSelUp = (e)-> moveSelTo [0, 0, 0, 50]
app.events.expandSelDown = (e)-> moveSelTo [0, -50, 0, 0]
app.events.expandSelRight = (e)-> moveSelTo [0, 0, 50, 0]
app.events.expandSelLeft = (e)-> moveSelTo [-50, 0, 0, 0]

app.events.shrinkSelUp = (e)-> moveSelTo [0, 50, 0, 0]
app.events.shrinkSelDown = (e)-> moveSelTo [0, 0, 0, -50]
app.events.shrinkSelRight = (e)-> moveSelTo [50, 0, 0, 0]
app.events.shrinkSelLeft = (e)-> moveSelTo [0, 0, -50, 0]
  ## expandSelUp
  ## shrinkSelUp