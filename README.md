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


## Breaking Changes
* Updated to work with `purs 0.11.x`
* Renamed the `WebAudio` effect to `AUDIO` to conform with best practices
* Renamed the `AudioNode` class as `RawAudioNode`
* `AudioNode` is now a sum type over all the raw nodes.
* Renamed `wau` to `audio`
* Moved several fns from `AudioContext.purs` to `BaseAudiocontext` to match web audio spec
* Created a `Connectable` class encompassing `connect`, `disconnect` & `connectParam` with AudioNode as an instance.  This lives in `Types.purs`

## Improvements
* Moved test/Test0X to `examples/` and renamed appropriately
* Added `AudioParam.setTargetAtTime`
* Updated `API.md` to reflect `decodeAudioData` error handling change
* New type synomymns `Value` and `Seconds` for `AudioParam` methods
* Eliminated `gulp`, putting new build test scripts in `package.json`
* Added `decodeAudioDataAsync` to `BaseAudioContext`. This runs in Aff not Eff but has the advantage that audio buffers can be returned directly. This, of course, introduces a dependency on Aff 4.0.0 and requires users to lift the original Eff functions into Aff if they wish to use it. I hope that this overhead should not be too restrictive given that a natural way to load sound resources is via Aff anyway.
* Added `decodeAsync` to illustrate basic usage. devDependencies now include `Affjax`.
* Added `test/props` to test some simple properties of the new Node types.
* Added `BiquadFilterNode`.
* Added `detune` property to `Oscillator`.
* Added `DelayNode`.
* Added `disconnect` to Types.
* Experimented with shorthand setters for `AudioParam` properties on some nodes.
* Added `AnalyserNode` plus buffer creation functions in Utils. This introduces a dependency on `Data.ArrayBuffer`.
* Added `StereoPannerNode`.
* Added `DynamicsCompressorNode`
* Added `ConvolverNode`

## adkelley ToDo:
* Add further error handling options for `decodeAudioData` besides writing to console
* Support for further nodes (e.g., ChannelSplitterNode), and interfaces

## newlandsvalley ToDo:
* Document the changes from merging my fork
