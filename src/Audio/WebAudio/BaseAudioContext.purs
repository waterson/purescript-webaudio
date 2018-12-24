module Audio.WebAudio.BaseAudioContext
       ( newAudioContext, destination, sampleRate, currentTime, state
       , suspend, resume, decodeAudioData, decodeAudioDataAsync
       , createBufferSource, createGain, createOscillator
       , createAnalyser, createBiquadFilter, createConvolver, createDelay
       , createDynamicsCompressor, createStereoPanner
       ) where

import Prelude

import Audio.WebAudio.Types
  ( AudioBuffer, AudioBufferSourceNode, AudioContext
  , DestinationNode, GainNode, OscillatorNode
  , DelayNode, BiquadFilterNode, AnalyserNode
  , StereoPannerNode, DynamicsCompressorNode, ConvolverNode
  , Seconds, Value, AudioContextState(..))
import Audio.WebAudio.Utils (unsafeGetProp)
import Effect (Effect)
import Effect.Aff (Aff)
import Effect.Aff.Compat (EffectFnAff, fromEffectFnAff)
import Data.ArrayBuffer.Types (ArrayBuffer)

-- | The audio graph whose AudioDestinationNode is routed to a real-time output device
-- | that produces a signal directed at the user.
-- | var context = new AudioContext()
foreign import newAudioContext :: Effect AudioContext

-- | An AudioDestinationNode with a single input representing the final destination for all audio.
destination :: AudioContext -> Effect DestinationNode
destination = unsafeGetProp "destination"

-- | The sample rate (in sample-frames per second) at which the BaseAudioContext handles audio.
foreign import sampleRate :: AudioContext -> Effect Value

foreign import currentTime :: AudioContext -> Effect Seconds

-- | An AudioListener which is used for 3D spatialization.
-- | todo: listener :: ..

foreign import _state :: AudioContext -> Effect String

-- | Describes the current state of this BaseAudioContext. (reaonly)
state :: AudioContext -> Effect AudioContextState
state ctx = do
  s <- _state ctx
  pure $
    case s of
      "suspended" -> SUSPENDED
      "running" -> RUNNING
      "closed" -> CLOSED
      _ -> CLOSED -- ^avoid making a Partial instance

foreign import suspend :: AudioContext -> Effect Unit

foreign import resume  :: AudioContext -> Effect Unit

-- | Closes the audio context, releasing any system audio resources used by the BaseAudioContext.
-- | todo: close :: ..

-- | A property used to set the EventHandler for an event that is dispatched to BaseAudioContext
-- | when the state of the AudioContext has changed (i.e. when the corresponding promise would have resolved).
-- | todo: onstatechange :: ..

-- | Asynchronously decodes the audio file data contained in the ArrayBuffer.
foreign import decodeAudioData
  :: AudioContext
  -> ArrayBuffer
  -> (AudioBuffer -> Effect Unit) -- sucesss
  -> (String -> Effect Unit) -- failure
  -> Effect Unit

foreign import decodeAudioDataAsyncImpl
  :: AudioContext
  -> ArrayBuffer
  -> EffectFnAff AudioBuffer

-- | decode the Audio Buffer asynchronously
decodeAudioDataAsync
  :: AudioContext
  -> ArrayBuffer
  -> Aff AudioBuffer
decodeAudioDataAsync ctx =
  fromEffectFnAff <<< (decodeAudioDataAsyncImpl ctx)


-- | Creates an AudioBufferSourceNode.
foreign import createBufferSource
  :: AudioContext
  -> Effect AudioBufferSourceNode

-- | Create a GainNode.
foreign import createGain
  :: AudioContext
  -> Effect GainNode

-- | Create an OscillatorNode
foreign import createOscillator
  :: AudioContext
  -> Effect OscillatorNode

-- | Create a DelayNode.
-- | createDelay also has an alternative constructor with a maximum delay
-- | note, if you don't set a max, it defaults to 1.0 and any attempt to set a greater value gives
-- | "paramDelay.delayTime.value 2 outside nominal range [0, 1]; value will be clamped."
foreign import createDelay
  :: AudioContext
  -> Effect DelayNode

-- | Create a BiquadFilterNode.
foreign import createBiquadFilter
  :: AudioContext
  -> Effect BiquadFilterNode

-- | create an AnalyserNode.
foreign import createAnalyser
  :: AudioContext
  -> Effect AnalyserNode

-- | Create a StereoPannerNode,
foreign import createStereoPanner
    :: AudioContext
    -> Effect StereoPannerNode

-- | Create a DynamicsCompressorNode.
foreign import createDynamicsCompressor
    :: AudioContext
    -> Effect DynamicsCompressorNode

-- | Create a ConvolverNode.
foreign import createConvolver
  :: AudioContext
  -> Effect ConvolverNode
