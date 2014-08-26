if !app? then window.app = {}
if !app.init? then app.init = {}
if !app.events? then app.events = {}

app.init.generateNavigation= ()->
  type = app.config.nav.type
  CONTENT = app.config.nav.CONTENT || region

  el = d.createDocumentFragment()
  nav = el.appendChild d.createElement("nav")
  ul = nav.appendChild d.createElement("ul")
  ul.className = "mainUl"

  registeredKeys = {}

  registerKeyEvent= (KEY, ahref)->
    lvl = 0
    keyObj = registeredKeys
    for key in KEY then if key is "ctrl"
      if !keyObj.ctrl? then keyObj.ctrl= {}
      keyObj = keyObj.ctrl
    for key in KEY then if key is "shift"
      if !keyObj.shift? then keyObj.shift= {}
      keyObj = keyObj.shift
    for key in KEY then if key is "alt"
      if !keyObj.alt? then keyObj.alt= {}
      keyObj = keyObj.alt
    keyObj[KEY[KEY.length-1]] = ahref

  triggerEvent = (event)->
    funct = app.events[event]
    if funct? then funct()
    else c.l "no event bind for "+ event

  getListItem = (itemName, item) ->
    li = d.createElement("li")
    ahref = li.appendChild d.createElement("a")
    ahref.innerHTML = itemName
    # assign all attributes
    for key, val of item
      if key isnt "CONTENT" and key isnt "ACTION" and key isnt "KEY"
        ahref[key] = val

    if item.KEY?
      lastKey = item.KEY[item.KEY.length-1]
      ahref.innerHTML = itemName.replace(lastKey, "<u>"+lastKey+"</u>")
      ahref.innerHTML = itemName.replace(lastKey.toUpperCase(), "<u>"+lastKey.toUpperCase()+"</u>")
      registerKeyEvent(item.KEY, ahref)
    if item.CONTENT?
      #c.l "create more ul an add dropdown event"
      ulSub = li.appendChild d.createElement("ul")
      ahref.className = "subUl"

      for itemName, item of item.CONTENT
        lili = getListItem(itemName, item)
        ulSub.appendChild lili
    else # no content
      #c.l "make a href with ACTION"
      if item.ACTION?
        #ahref.href = "/#"  +  item.ACTION
        ahref.addEventListener "click", ->
          triggerEvent item.ACTION
    li


  document.addEventListener "keydown", (e) ->
    keyObj = registeredKeys
    key = String.fromCharCode(e.keyCode).toLowerCase()
    if e.ctrlKey and  keyObj.ctrl then keyObj = keyObj.ctrl
    if e.shiftKey and  keyObj.shift then keyObj = keyObj.shift
    if e.altKey and keyObj.alt then keyObj = keyObj.alt
    if keyObj[key]? then keyObj[key].click()
    c.l keyObj[key]
    e.preventDefault()

  for itemName, item of CONTENT
    li = getListItem(itemName, item)
    ul.appendChild li

  d.getElementById("nav").appendChild el

