module Audio.WebAudio.Types
  ( class RawAudioNode, class Connecting, AudioNode(..)
  , AudioBuffer, AudioBufferSourceNode, AudioContext
  , AudioParam, DestinationNode, BiquadFilterNode
  , GainNode, MediaElementAudioSourceNode
  , DelayNode, OscillatorNode, AnalyserNode, WebAudio
  , connect, disconnect, connectParam) where

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

-- | a 'raw' web-audio node
class RawAudioNode n

instance audioNodeAudioBufferSourceNode :: RawAudioNode AudioBufferSourceNode
instance audioNodeMediaElementAudioSourceNode :: RawAudioNode MediaElementAudioSourceNode
instance audioNodeGainNode :: RawAudioNode GainNode
instance audioNodeDestinationNode :: RawAudioNode DestinationNode
instance audioNodeOscillatorNode :: RawAudioNode OscillatorNode
instance audioNodeBiquadFilterNode :: RawAudioNode BiquadFilterNode
instance audioNodeDelayNode :: RawAudioNode DelayNode
instance audioNodeAnalyserNode :: RawAudioNode AnalyserNode

-- | a web audio node that can connect to another node
class Connecting s where
  connect ::  ∀ eff target. RawAudioNode target => s -> target -> (Eff (wau :: WebAudio | eff) Unit)
  disconnect ::  ∀ eff target. RawAudioNode target => s -> target -> (Eff (wau :: WebAudio | eff) Unit)
  connectParam  :: ∀ eff target. RawAudioNode target => s -> target -> String -> (Eff (wau :: WebAudio | eff) Unit)

instance connectingAudioBufferSourceNode :: Connecting AudioBufferSourceNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectingMediaElementAudioSourceNode :: Connecting MediaElementAudioSourceNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectingGainNode :: Connecting GainNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectingOscillatorNode :: Connecting OscillatorNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectingiquadFilterNode :: Connecting BiquadFilterNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectingDelayNode  :: Connecting DelayNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectingAnalyserNode  :: Connecting AnalyserNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectingAudioNode :: Connecting AudioNode where
  connect (Gain n) = nodeConnect n
  connect (AudioBufferSource n) = nodeConnect n
  connect (Oscillator n) = nodeConnect n
  connect (BiquadFilter n) = nodeConnect n
  connect (Delay n) = nodeConnect n
  connect (Analyser n) = nodeConnect n

  disconnect (Gain n) = nodeDisconnect n
  disconnect (AudioBufferSource n) = nodeDisconnect n
  disconnect (Oscillator n) = nodeDisconnect n
  disconnect (BiquadFilter n) = nodeDisconnect n
  disconnect (Delay n) = nodeDisconnect n
  disconnect (Analyser n) = nodeDisconnect n

  connectParam (Gain n) t p = unsafeConnectParam n t p
  connectParam (AudioBufferSource n) t p = unsafeConnectParam n t p
  connectParam (Oscillator n) t p = unsafeConnectParam n t p
  connectParam (BiquadFilter n) t p = unsafeConnectParam n t p
  connectParam (Delay n) t p = unsafeConnectParam n t p
  connectParam (Analyser n) t p = unsafeConnectParam n t p


-- foreign import connect
foreign import nodeConnect  :: ∀ m n eff. RawAudioNode m => RawAudioNode n => m
  -> n
  -> (Eff (wau :: WebAudio | eff) Unit)

-- There are multiple disconnect options - this one seems the most useful
-- foreign import disconnectRawA
foreign import nodeDisconnect  :: ∀ m n eff. RawAudioNode m => RawAudioNode n => m
  -> n
  -> (Eff (wau :: WebAudio | eff) Unit)

-- | experimental
-- | the String parameter names an audio parameter on the target node, n
-- | this function connects this audio parameter to node m
-- |
-- | it seems we need to do this as an atomic operation
-- | If we have separate monadic functions to get the audio parameter
-- | and to connect a node to it, then it fails to work.
-- | The Web-Audio JavaScript requires the original parameter, not a copy
-- |
-- | This is very unsafe.  The parameter must exist on the target.
foreign import unsafeConnectParam  :: ∀ m n eff. RawAudioNode m => RawAudioNode n => m
  -> n
  -> String
  -> (Eff (wau :: WebAudio | eff) Unit)

data AudioNode =
    Gain GainNode
  | AudioBufferSource AudioBufferSourceNode
  | Oscillator OscillatorNode
  | BiquadFilter BiquadFilterNode
  | Delay DelayNode
  | Analyser AnalyserNode
