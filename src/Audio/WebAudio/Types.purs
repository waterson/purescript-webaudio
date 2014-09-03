module Audio.WebAudio.Types where

foreign import data WebAudio :: !

foreign import data AudioBuffer :: *
foreign import data AudioBufferSourceNode :: *
foreign import data AudioContext :: *
foreign import data AudioParam :: *
foreign import data DestinationNode :: *
foreign import data GainNode :: *
foreign import data MediaElementAudioSourceNode :: *
foreign import data OscillatorNode :: *

class AudioNode n

