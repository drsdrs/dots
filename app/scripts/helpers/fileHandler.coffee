if !app? then window.app = {}
if !app.helpers? then app.helpers = {}

#////////// FILE HANDLER //////////////

class app.helpers.FileStorrage
  constructor: (elId, dataObj) ->
    elId = if !elId? then "fileInput"

    if !dataObj?
      app.data = []
      @dataObj = app.data
    else @dataObj = dataObj

    fileBtn = document.getElementById(elId)
    fileInput = document.createElement("input")
    fileInput.type = "file"
    fileInput.className = "hidden"
    fileBtn.appendChild fileInput

     # <input value="LOAD FILE HIDDEN" id="fileInput" type="file"/ class="hidden">
    fileBtn.addEventListener('click', ->
      fileInput.click()
    , false)

    fileBtn.addEventListener('change', @handleFileSelect.bind(@), false)

  handleFileSelect: (e) ->
    file = e.target.files[0]
    type = file.type.toLowerCase
    self = @
    if file.size < 3*1000000#mB
      reader = new FileReader()
      # Closure to capture the file information.
      reader.onload = ((e) ->
        (e) ->
          if type is "json"
            data = JSON.parse e.target.result
          else
            data = e.target.result
          self.dataObj.push data
      )(file)
      if type is "json"
        reader.readAsText file
      else
        reader.readAsDataURL file
    else alert "file to big..."

  download: (filename, text) ->
    json = JSON.stringify app.modes
    el = document.createElement("a")
    el.setAttribute(
      "href", "data:text/plain;charset=utf-8,"+encodeURIComponent(json)
    )
    el.setAttribute "download", filename
    el.click()

  save: ->
    data = JSON.stringify app.modes
    c.l data
    location.href = 'data:application/octet-stream,'+encodeURIComponent(data)
    #newWindow= window.open(dataUri, 'song', "song")
