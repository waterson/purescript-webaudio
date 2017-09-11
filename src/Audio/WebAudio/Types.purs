module Audio.WebAudio.Types
  ( class AudioNode, AudioBuffer, AudioBufferSourceNode
  , AudioContext, AudioParam, DestinationNode
  , GainNode, MediaElementAudioSourceNode, OscillatorNode, WebAudio) where

import Control.Monad.Eff (kind Effect)

foreign import data WebAudio :: Effect

foreign import data AudioBuffer :: Type
foreign import data AudioBufferSourceNode :: Type
foreign import data AudioContext :: Type
foreign import data AudioParam :: Type
foreign import data DestinationNode :: Type
foreign import data GainNode :: Type
foreign import data MediaElementAudioSourceNode :: Type
foreign import data OscillatorNode :: Type

class AudioNode n

instance audioNodeAudioBufferSourceNode :: AudioNode AudioBufferSourceNode
instance audioNodeMediaElementAudioSourceNode :: AudioNode MediaElementAudioSourceNode
instance audioNodeGainNode :: AudioNode GainNode
instance audioNodeDestinationNode :: AudioNode DestinationNode
instance audioNodeOscillatorNode :: AudioNode OscillatorNode
