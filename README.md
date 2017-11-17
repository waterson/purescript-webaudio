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

## newlandsvalley proposed changes

I think it is now possible, with the latest Aff, to make the __decodeAudioData__ function less clumsy.  At the moment it requires continuations in Eff for both success and failure.  However, Aff would allow a return type where you can actually get your hands on the AudioBuffer:
 
    forall eff. Uint8Array -> Aff (wau :: WebAudio | eff) AudioBuffer
    
and so this means, if you're happy to work in Aff rather than Eff, AudioBuffers can be saved for later use and so on.

## adkelley Changes 
* Updated to work with `purs 0.11.x`
* Updated tests to use `purescript-dom` and some components from `purescript-simple-dom`
* Updated `testXX.html` files to run `testXX.js` implicitly after `window` object is loaded
* Updated `API.md` to reflect `decodeAudioData` error handling change
* Eliminated `gulp`, putting new build test scripts in `package.json`

## adkelley ToDo:
* Add further error handling options for `decodeAudioData` besides writing to console
* Support for further nodes (e.g., ChannelSplitterNode), and interfaces
