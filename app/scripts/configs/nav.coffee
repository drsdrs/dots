if !app? then window.app = {}
if !app.config? then app.config = {}
app.config.nav =
  type: "hnav"
  CONTENT:
    "Load img":
      KEY: ["ctrl", "l"]
      id: "fileInput"
    Play:
      KEY: ["ctrl", "p"]
      ACTION: "play"
    Stop:
      KEY: ["ctrl", "s"]
      ACTION: "stop"
    "SwitchImage":
      KEY: ["y"]
      ACTION: "switchImage"