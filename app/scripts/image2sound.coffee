if !app? then window.app = {}
if !app.init? then app.init = {}
if !app.events? then app.events = {}



contextWave = null
contextSeq = null

canvasWave = null
canvasSeq = null

audioCtx = null

app.init.playSnd= ->
  canvasWave = document.getElementById("canvasWave")
  canvasWavemod = document.getElementById("canvasWavemod")
  canvasSeq = document.getElementById("canvasSeq")
  contextWave = canvasWave.getContext("2d")
  contextWavemod = canvasWavemod.getContext("2d")
  contextSeq = canvasSeq.getContext("2d")


  audioCtx = new (window.AudioContext or window.webkitAudioContext)()

  frameCount = audioCtx.sampleRate * 16
  channels = 1
  dpos = 0
  mpos = 0
  npos = 0
  spos = 0
  soundgen = (->
    bufferSize = 2048
    node = audioCtx.createScriptProcessor(bufferSize, 0, 1)

    node.onaudioprocess = (e) ->
      imgdataWave = contextWave.getImageData(0, 0, canvasWave.width, canvasWave.height).data
      imgdataWavemod = contextWavemod.getImageData(0, 0, canvasWavemod.width, canvasWavemod.height).data
      imgdataSeq = contextSeq.getImageData(0, 0, canvasSeq.width, canvasSeq.height).data
      waveLength = imgdataWave.length
      wavemodLength = imgdataWavemod.length
      seqLength = imgdataSeq.length

      output = e.outputBuffer.getChannelData(0)
      npos = 0
      #return c.l seqLength, waveLength
      while npos<output.length
        rW= imgdataWave[dpos+0] # RED
        gW= imgdataWave[dpos+1] # GREEN
        bW= imgdataWave[dpos+2] # BLUE
        aW= imgdataWave[dpos+3] # TRANSPARENT

        rM= imgdataWavemod[~~(mpos+0)] # RED
        gM= imgdataWavemod[~~(mpos+1)] # GREEN
        bM= imgdataWavemod[~~(mpos+2)] # BLUE

        rS= imgdataSeq[~~(spos+0)] # RED
        gS= imgdataSeq[~~(spos+1)] # GREEN
        bS= imgdataSeq[~~(spos+2)] # BLUE

        #pix = (r+b+g)/3
        pix = ((rW+rM)-(rS))+((gW-gM)+(gS))-((bW+bM)-(rS))
        pix = pix
        pix = ((pix&aW)/128)-1
        pix *= 0.3
        #if dpos%bufferSize/8 is 0 then c.l [imgdata[dpos], imgdata[dpos+1], imgdata[dpos+2], imgdata[dpos+3]], b
        output[npos] = pix
        if spos>=seqLength then spos = 0
        if dpos>=waveLength then dpos = 0
        if mpos>=wavemodLength then mpos = 0
        dpos+=4
        mpos+=0.4
        spos+=0.04
        npos+=1

    node
  )()


  app.events.play = -> soundgen.connect audioCtx.destination
  app.events.stop = -> soundgen.disconnect()
