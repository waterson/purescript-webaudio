# purescript-webaudio

## About

This is an experimental library for dealing with the HTML5 [Web Audio
API](https://dvcs.w3.org/hg/audio/raw-file/tip/webaudio/specification.html).

Module documentation is available [here](API.md).

To run the tests in your browser, perform the following scripts in order:
1. `npm run Tests`
2. `npm run server`  *--optionial*

Step 1 will run `pulp browserify` on `TestXX.purs` (currently `Test01.purs` through `Test03.purs`) and place the resulting file, `testXX.js` in the `html/` directory.

Step 2 is optional as you may wish to run your own http server. The script will start a server (python -m SimpleHTTPServer) on port 8000.  Point your browser to `localhost:8000` and select `testXX.html`.

Note: If you make a change to `TestXX.purs` then run the script `npm run TestXX`

Note: To run `Test03`, I ported some components from [purescript-simple-dom](https://github.com/aktowns/purescript-simple-dom). These are contained in the module `test/SimpleDom.*`

## newlandsvalley changes

* Added __decodeAudioDataAsync__ to AudioContext.  This runs in Aff not Eff but has the advantage that audio buffers can be returned directly.  This, of course, introduces a dependency on Aff 4.0.0 and requires users to lift the original Eff functions into Aff if they wish to use it.  I hope that this overhead should not be too restrictive given that a natural way to load sound resources is via Aff anyway.
* Added Test04 to illustrate basic usage.  devDependencies now include Affjax.
* Added three new wav resources to the html example directory - hihat, kick and snare.
* Added TestProps to test some simple properties of the new Node types.
* Added BiquadFilterNode (together with some property testing).
* Added detune property to Oscillator.
* Added DelayNode.
* Added disconnect to AudioContext.
* Experiment with shorthand setters for AudioParam properties on some nodes.
* Added AnalyserNode plus buffer creation functions in Utils.  This introduces a dependency on Data.ArrayBuffer.
* Added StereoPannerNode
* Added DynamicsCompressorNode
* Added ConvolverNode

### breaking changes

* Renamed class __AudioNode__ to __RawAudioNode__
* Added class __Connectable__ to represent nodes that can be connect to from others.  Moved __connect__ and __disconnect__ from AudioContext to Types. 
* __AudioNode__ now represents a sum type over all the raw audio nodes and is an instance of __Connectable__

### examples

Samples exercising most of these changes are to be found at [webaudio-examples](https://github.com/newlandsvalley/webaudio-examples) and at [purescript-audiograph](https://github.com/newlandsvalley/purescript-audiograph) (which is an attempt to provide a declarative interface to web-audio).  


## adkelley changes
* Updated to work with `purs 0.11.x`
* Updated tests to use `purescript-dom` and some components from `purescript-simple-dom`
* Updated `testXX.html` files to run `testXX.js` implicitly after `window` object is loaded
* Updated `API.md` to reflect `decodeAudioData` error handling change
* Eliminated `gulp`, putting new build test scripts in `package.json`

## adkelley ToDo:
* Add further error handling options for `decodeAudioData` besides writing to console
* Support for further nodes (e.g., ChannelSplitterNode), and interfaces
