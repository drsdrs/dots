API =
  getImage: -> canvas.toBuffer()
  drawCircle: (x, y, r, col)->
      ctx.beginPath()
      ctx.arc(x, y, r, 0, 2 * Math.PI, false)
      ctx.fillStyle = col
      ctx.fill()

  drawLine: (x1, y1, x2, y2, col)->
      ctx.beginPath()
      ctx.strokeStyle = col
      ctx.moveTo(x1, y1)
      ctx.lineTo(x2, y2)
      ctx.stroke()

Canvas = require('canvas')
Image = Canvas.Image
canvas = new Canvas(320,320)
canvas.width = 255
canvas.height = 16384/ canvas.width
ctx = canvas.getContext('2d')

#ctx.antialias = 'none'

ctx.font = '30px Impact'
ctx.rotate(.1)
ctx.fillText("Awesome!", 50, 100)

te = ctx.measureText('Awesome!')
ctx.strokeStyle = 'rgba(255,255,255,0.5)'
ctx.beginPath()
ctx.lineTo(50, 102)
ctx.lineTo(50 + te.width, 102)
ctx.stroke()

exports.API = API