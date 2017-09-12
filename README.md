# purescript-webaudio

## About
Forked from https://github.com/waterson/purescript-webaudio

This is an experimental library for dealing with the HTML5 [Web Audio
API](https://dvcs.w3.org/hg/audio/raw-file/tip/webaudio/specification.html).

Module documentation is available [here](API.md).

If you make a change to TestXX then:
`npm run TestXX` where XX is the test number (currently 01 & 02).  This will run `pulp browserify` on `TestXX.purs` and place `testXX.js` in the `html/` directory.

To run the tests, then `cd` to `html/` and start up a web server.  I've done this for you with `npm run server`

## Changes
* Updated to work with purs 0.11.6
* Test03 is WIP
