if !app? then window.app = {}
if !app.config? then app.config = {}
app.config.nav =
  type: "hnav"
  CONTENT:
    "Load img":
      KEY: ["ctrl", "l"]
      id: "fileInput"
    "Play":
      KEY: ["ctrl", "p"]
      ACTION: "play"
    "Stop":
      KEY: ["ctrl", "s"]
      ACTION: "stop"
    "SwitchImage":
      KEY: ["y"]
      ACTION: "switchImage"
    "set rnd from list":
      KEY: ["r"]
      ACTION: "getRandomImg"
    "Selection":
      CONTENT:
        "move":
          CONTENT:
            up:
              KEY: ["j"]
              ACTION: "selUp"
            down:
              KEY: ["k"]
              ACTION: "selDown"
            left:
              KEY: ["h"]
              ACTION: "selLeft"
            right:
              KEY: ["l"]
              ACTION: "selRight"
        "expand":
          CONTENT:
            up:
              KEY: ["shift", "j"]
              ACTION: "expandSelUp"
            down:
              KEY: ["shift", "k"]
              ACTION: "expandSelDown"
            left:
              KEY: ["shift", "h"]
              ACTION: "expandSelLeft"
            right:
              KEY: ["shift", "l"]
              ACTION: "expandSelRight"
        "shrink":
          CONTENT:
            up:
              KEY: ["ctrl", "j"]
              ACTION: "shrinkSelUp"
            down:
              KEY: ["ctrl", "k"]
              ACTION: "shrinkSelDown"
            left:
              KEY: ["ctrl", "h"]
              ACTION: "shrinkSelLeft"
            right:
              KEY: ["ctrl", "l"]
              ACTION: "shrinkSelRight"