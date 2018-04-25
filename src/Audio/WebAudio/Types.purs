module Audio.WebAudio.Types
  ( class AudioNode, AUDIO, AudioBuffer, AudioBufferSourceNode
  , AudioContext, AudioParam, DestinationNode
  , GainNode, MediaElementAudioSourceNode, OscillatorNode
  , AudioContextState(..), AudioContextPlaybackCategory(..)
  , Value, Seconds) where

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

data AudioContextState = SUSPENDED | RUNNING | CLOSED

derive instance eqAudioContextState :: Eq AudioContextState
instance showAudioContextState :: Show AudioContextState where
  show SUSPENDED = "suspended"
  show RUNNING = "running"
  show CLOSED = "closed"

data AudioContextPlaybackCategory = BALANCED | INTERACTIVE | PLAYBACK
derive instance eqAudioPlaybackCategory :: Eq AudioContextPlaybackCategory
instance showAudioContextPlaybackCategory :: Show AudioContextPlaybackCategory where
  show BALANCED = "balanced"
  show INTERACTIVE = "interactive"
  show PLAYBACK = "playback"


-- | Type synonym for the value argument (e.g., Volume)
type Value = Number

-- | Type synonym for time (in seconds) argument
type Seconds = Number

class AudioNode n

instance audioNodeAudioBufferSourceNode :: AudioNode AudioBufferSourceNode
instance audioNodeMediaElementAudioSourceNode :: AudioNode MediaElementAudioSourceNode
instance audioNodeGainNode :: AudioNode GainNode
instance audioNodeDestinationNode :: AudioNode DestinationNode
instance audioNodeOscillatorNode :: AudioNode OscillatorNode
