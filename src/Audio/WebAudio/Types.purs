module Audio.WebAudio.Types
  ( class RawAudioNode, class Connectable, AudioNode(..)
  , AudioBuffer, AudioBufferSourceNode, AudioContext
  , AudioParam, DestinationNode, BiquadFilterNode
  , GainNode, MediaElementAudioSourceNode
  , DelayNode, OscillatorNode, AnalyserNode, StereoPannerNode
  , DynamicsCompressorNode, ConvolverNode, WebAudio
  , connect, disconnect, connectParam) where

import Control.Monad.Eff (kind Effect, Eff)
import Prelude (Unit, pure, unit)

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
foreign import data StereoPannerNode :: Type
foreign import data DynamicsCompressorNode :: Type
foreign import data ConvolverNode :: Type

-- | a 'raw' web-audio node
class RawAudioNode n

instance audioNodeAudioBufferSourceNodeconnectParam :: RawAudioNode AudioBufferSourceNode
instance audioNodeMediaElementAudioSourceNode :: RawAudioNode MediaElementAudioSourceNode
instance audioNodeGainNode :: RawAudioNode GainNode
instance audioNodeDestinationNode :: RawAudioNode DestinationNode
instance audioNodeOscillatorNode :: RawAudioNode OscillatorNode
instance audioNodeBiquadFilterNode :: RawAudioNode BiquadFilterNode
instance audioNodeDelayNode :: RawAudioNode DelayNode
instance audioNodeAnalyserNode :: RawAudioNode AnalyserNode
instance audioNodeStereoPannerNode :: RawAudioNode StereoPannerNode
instance audioNodeDynamicsCompressorNode :: RawAudioNode DynamicsCompressorNode
instance audioNodeDynamicsCConvolverNode :: RawAudioNode ConvolverNode

-- | a web audio node that is connectable/disconnectable from another node
-- | or whose parameter(s) may be connectable from another node
class Connectable target where
  connect ::  ∀ eff source. RawAudioNode source => source -> target -> (Eff (wau :: WebAudio | eff) Unit)
  disconnect ::  ∀ eff source. RawAudioNode source => source -> target -> (Eff (wau :: WebAudio | eff) Unit)
  connectParam  :: ∀ eff source. RawAudioNode source => source -> target -> String -> (Eff (wau :: WebAudio | eff) Unit)

instance connectableGainNode :: Connectable GainNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectableOscillatorNode :: Connectable OscillatorNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectableBiquadFilterNode :: Connectable BiquadFilterNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectableDelayNode  :: Connectable DelayNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectableAnalyserNode  :: Connectable AnalyserNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectableStereoPannerNode  :: Connectable StereoPannerNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectableDynamicsCompressorNode  :: Connectable DynamicsCompressorNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectableConvolverNode  :: Connectable ConvolverNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectableDestinationNode  :: Connectable DestinationNode where
  connect = nodeConnect
  disconnect = nodeDisconnect
  connectParam = unsafeConnectParam

instance connectableAudioNode :: Connectable AudioNode where
  connect s (Gain n) = nodeConnect s n
  connect s (Oscillator n) = nodeConnect s n
  connect s (BiquadFilter n) = nodeConnect s n
  connect s (Delay n) = nodeConnect s n
  connect s (Analyser n) = nodeConnect s n
  connect s (StereoPanner n) = nodeConnect s n
  connect s (DynamicsCompressor n) = nodeConnect s n
  connect s (Convolver n) = nodeConnect s n
  connect s (Destination n) = nodeConnect s n
  connect s _ = pure unit  -- you can't connect to source nodes

  disconnect s (Gain n) = nodeDisconnect s n
  disconnect s (Oscillator n) = nodeConnect s n
  disconnect s (BiquadFilter n) = nodeDisconnect s n
  disconnect s (Delay n) = nodeDisconnect s n
  disconnect s (Analyser n) = nodeDisconnect s n
  disconnect s (StereoPanner n) = nodeDisconnect s n
  disconnect s (DynamicsCompressor n) = nodeDisconnect s n
  disconnect s (Convolver n) = nodeDisconnect s n
  disconnect s (Destination n) = nodeConnect s n
  disconnect s _ = pure unit -- you can't disconnect from source nodes

  connectParam s (Gain n) p = unsafeConnectParam s n p
  -- not sure yet if you can connect to params on source nodes like the next two
  connectParam s (AudioBufferSource n) p = unsafeConnectParam s n p
  connectParam s (Oscillator n) p = unsafeConnectParam s n p
  connectParam s (BiquadFilter n) p = unsafeConnectParam s n p
  connectParam s (Delay n) p = unsafeConnectParam s n p
  connectParam s (Analyser n) p = unsafeConnectParam s n p
  connectParam s (StereoPanner n) p = unsafeConnectParam s n p
  connectParam s (DynamicsCompressor n) p = unsafeConnectParam s n p
  connectParam s (Convolver n) p = unsafeConnectParam s n p
  connectParam s (Destination n) p = pure unit

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
  | StereoPanner StereoPannerNode
  | DynamicsCompressor DynamicsCompressorNode
  | Convolver ConvolverNode
  | Destination DestinationNode
