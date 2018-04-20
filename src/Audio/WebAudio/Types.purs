module Audio.WebAudio.Types
  ( class AudioNode, AudioBuffer, AudioBufferSourceNode
  , AudioContext, AudioParam, DestinationNode
  , GainNode, MediaElementAudioSourceNode, OscillatorNode
  , Value, Seconds, AUDIO, AudioContextState(..)) where

import Prelude

import Control.Monad.Eff (kind Effect)

foreign import data AUDIO :: Effect

foreign import data AudioBuffer :: Type
foreign import data AudioBufferSourceNode :: Type
foreign import data AudioContext :: Type
foreign import data AudioParam :: Type
foreign import data DestinationNode :: Type
foreign import data GainNode :: Type
foreign import data MediaElementAudioSourceNode :: Type
foreign import data OscillatorNode :: Type

-- | Type synonym for the value (e.g., Volume) of an AudioParam
type Value = Number

-- | Type synonym for time (in seconds)
type Seconds = Number

-- | Type synonym for possible values for AudioContextState

data AudioContextState = SUSPENDED | RUNNING | CLOSED

derive instance eqAudioContextState :: Eq AudioContextState
instance showAudioContextState :: Show AudioContextState where
  show SUSPENDED = "suspended"
  show RUNNING = "running"
  show CLOSED = "closed"


class AudioNode n

instance audioNodeAudioBufferSourceNode :: AudioNode AudioBufferSourceNode
instance audioNodeMediaElementAudioSourceNode :: AudioNode MediaElementAudioSourceNode
instance audioNodeGainNode :: AudioNode GainNode
instance audioNodeDestinationNode :: AudioNode DestinationNode
instance audioNodeOscillatorNode :: AudioNode OscillatorNode
