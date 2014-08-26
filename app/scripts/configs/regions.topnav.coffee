if !app? then window.app = {}

if !app.regions? then app.regions = {}
app.regions.topnav =
  type: "hnav"
  CONTENT:
    File:
      CONTENT:
        New: true
        Load:
          KEY: ["ctrl", "l"]
          id: "fileInput"
          className: "buhu"
          name: "extraOrdinaer"
        Save:
          KEY: ["strg", "s"]
          ACTION: "saveFile"
        google:
          href: "http://www.google.com"
          target: "_blank"
          KEY: ["ctrl", "shift", "g"]

    Generate:
      KEY: ["ctrl", "g"]
      ACTION: "generate"
    Edit:
      KEY: ["ctrl", "y"]
    Help:
      href: "http://de.wikipedia.org/wiki/Manpage"
      target: "_blank"
