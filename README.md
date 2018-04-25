# purescript-webaudio

## About

This is an experimental library for dealing with the HTML5 [Web Audio
API](https://dvcs.w3.org/hg/audio/raw-file/tip/webaudio/specification.html).

Module documentation is available [here](API.md).

To build the examples to run in your browser, perform the following scripts in order:
1. `npm run build:example:xx` where xx is the example (siren, gain, decode, decodeAsync)

To run the examples in your browser, perform the following scripts in order:
1. `npm run exec:example:xx` where xx is the example (siren, gain, decode, decodeAsync)

To build the test suite
1. `npm run build:test:props`

To run the test suite
1. `npm run exec:test:props` and inspect the output log

* Updated to work with `purs 0.11.x`
* Moved test/Test0X to `examples/` and renamed appropriately
* Updated `API.md` to reflect `decodeAudioData` error handling change
* Eliminated `gulp`, putting new build test scripts in `package.json`

## adkelley ToDo:
* Add further error handling options for `decodeAudioData` besides writing to console
* Support for further nodes (e.g., ChannelSplitterNode), and interfaces

## newlandsvalley ToDo:
* Document the changes from merging my fork
