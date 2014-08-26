filetypes = ["jpg","png","gif"]

for type in filetypes
  i = 0
  ul = $("#imageList")
  c.l type
  getNextImage = (type, i)->
    imgSrc = "images/"+i+"."+type
    jqxhr = $.get(imgSrc
    ).done(->
      #c.l "second success", imgSrc
      i++
      ul.append("<li><img src='"+imgSrc+"' /></li>")
      setTimeout (->getNextImage(type, i)), 0
    ).fail(->
      #c.l "stop", imgSrc, type
    )
  getNextImage(type, i)

$("#imageList").on "click", (e)->
  $(".activeListImg").removeClass("activeListImg")
  e.target.className = "activeListImg"
  app.events.loadImgIntoActive(e)