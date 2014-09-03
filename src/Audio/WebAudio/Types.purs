module Audio.WebAudio.Types where

foreign import data WebAudio :: !
foreign import data AudioContext :: *
foreign import data OscillatorNode :: *
foreign import data DestinationNode :: *
foreign import data MediaElementAudioSourceNode :: *
foreign import data AudioBuffer :: *
foreign import data AudioBufferSourceNode :: *

class AudioNode n

