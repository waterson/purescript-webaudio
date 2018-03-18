module Audio.WebAudio.Types
  ( class AudioNode, class Connecting, AudioBuffer, AudioBufferSourceNode
  , AudioContext, AudioParam, DestinationNode, BiquadFilterNode
  , GainNode, MediaElementAudioSourceNode
  , DelayNode, OscillatorNode, AnalyserNode, WebAudio
  , connect, disconnect) where

import Control.Monad.Eff (kind Effect, Eff)
import Prelude (Unit)

foreign import data WebAudio :: Effect

foreign import data AudioBuffer :: Type
foreign import data AudioBufferSourceNode :: Type
foreign import data AudioContext :: Type
foreign import data AudioParam :: Type
foreign import data DestinationNode :: Type
foreign import data GainNode :: Type
foreign import data MediaElementAudioSourceNode :: Type
foreign import data OscillatorNode :: Type
foreign import data BiquadFilterNode :: Type
foreign import data DelayNode :: Type
foreign import data AnalyserNode :: Type

-- | a web-audio node
class AudioNode n

instance audioNodeAudioBufferSourceNode :: AudioNode AudioBufferSourceNode
instance audioNodeMediaElementAudioSourceNode :: AudioNode MediaElementAudioSourceNode
instance audioNodeGainNode :: AudioNode GainNode
instance audioNodeDestinationNode :: AudioNode DestinationNode
instance audioNodeOscillatorNode :: AudioNode OscillatorNode
instance audioNodeBiquadFilterNode :: AudioNode BiquadFilterNode
instance audioNodeDelayNode :: AudioNode DelayNode
instance audioNodeAnalyserNode :: AudioNode AnalyserNode

-- | a web audio node that can connect to another node
class Connecting s where
  connect ::  ∀ eff target. AudioNode target => s -> target -> (Eff (wau :: WebAudio | eff) Unit)
  disconnect ::  ∀ eff target. AudioNode target => s -> target -> (Eff (wau :: WebAudio | eff) Unit)

instance connectableAudioBufferSourceNode :: Connecting AudioBufferSourceNode where
  connect = nodeConnect
  disconnect = nodeDisconnect

instance connectableMediaElementAudioSourceNode :: Connecting MediaElementAudioSourceNode where
  connect = nodeConnect
  disconnect = nodeDisconnect

instance connectableGainNode :: Connecting GainNode where
  connect = nodeConnect
  disconnect = nodeDisconnect

instance connectableOscillatorNode :: Connecting OscillatorNode where
  connect = nodeConnect
  disconnect = nodeDisconnect

instance connectableBiquadFilterNode :: Connecting BiquadFilterNode where
  connect = nodeConnect
  disconnect = nodeDisconnect

instance connectableDelayNode  :: Connecting DelayNode where
  connect = nodeConnect
  disconnect = nodeDisconnect

instance connectableAnalyserNode  :: Connecting AnalyserNode where
  connect = nodeConnect
  disconnect = nodeDisconnect

-- foreign import connect
foreign import nodeConnect  :: ∀ m n eff. AudioNode m => AudioNode n => m
  -> n
  -> (Eff (wau :: WebAudio | eff) Unit)

-- There are multiple disconnect options - this one seems the most useful
-- foreign import disconnect
foreign import nodeDisconnect  :: ∀ m n eff. AudioNode m => AudioNode n => m
  -> n
  -> (Eff (wau :: WebAudio | eff) Unit)

{-
data WebAudioNode =
    Gain GainNode
  | AudioBufferSource AudioBufferSourceNode
  | Oscillator OscillatorNode
  | BiquadFilter BiquadFilterNode
  | Delay DelayNode
  | Analyser AnalyserNode
-}
