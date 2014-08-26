###midi = null

onMIDIFailure = (msg) ->
  console.log "Failed to get MIDI access - ",msg
  return
listInputsAndOutputs = (midiAccess) ->
  for input of midiAccess.inputs
    console.log "Input port [type:'" + input.type + "'] id:'" + input.id + "' manufacturer:'" + input.manufacturer + "' name:'" + input.name + "' version:'" + input.version + "'"
  for output of midiAccess.outputs
    console.log "Output port [type:'" + output.type + "'] id:'" + output.id + "' manufacturer:'" + output.manufacturer + "' name:'" + output.name + "' version:'" + output.version + "'"
  

navigator.requestMIDIAccess().then listInputsAndOutputs, onMIDIFailure###


