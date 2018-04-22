module Audio.WebAudio.BaseAudioContext
       ( newAudioContext, destination, sampleRate, currentTime, state
       , suspend, resume, decodeAudioData, createBufferSource
       , createGain, createOscillator
       ) where

import Prelude

import Audio.WebAudio.Types
  ( AUDIO, AudioBuffer, AudioBufferSourceNode, AudioContext
  , DestinationNode, GainNode, OscillatorNode
  , Seconds, Value, AudioContextState(..))
import Audio.WebAudio.Utils (unsafeGetProp)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Data.ArrayBuffer.Types (ArrayBuffer)

-- | The audio graph whose AudioDestinationNode is routed to a real-time output device
-- | that produces a signal directed at the user.
-- | var context = new AudioContext()
foreign import newAudioContext
  :: ∀ eff. (Eff (audio :: AUDIO | eff) AudioContext)

-- | An AudioDestinationNode with a single input representing the final destination for all audio.
destination
  :: ∀ eff. AudioContext
  -> (Eff (audio :: AUDIO | eff) DestinationNode)
destination = unsafeGetProp "destination"

-- | The sample rate (in sample-frames per second) at which the BaseAudioContext handles audio.
foreign import sampleRate
  :: ∀ eff. AudioContext
  -> (Eff (audio :: AUDIO | eff) Value)

foreign import currentTime
  :: ∀ eff. AudioContext
  -> (Eff (audio :: AUDIO | eff) Seconds)

-- | An AudioListener which is used for 3D spatialization.
-- | todo: listener :: ..

foreign import _state :: ∀ eff. AudioContext -> Eff (audio :: AUDIO | eff) String

-- | Describes the current state of this BaseAudioContext. (reaonly)
state :: ∀ eff. AudioContext -> Eff (audio :: AUDIO | eff) AudioContextState
state ctx = do
  s <- _state ctx
  pure $
    case s of
      "suspended" -> SUSPENDED
      "running" -> RUNNING
      "closed" -> CLOSED
      _ -> CLOSED -- ^avoid making a Partial instance

foreign import suspend :: ∀ eff. AudioContext -> Eff (audio :: AUDIO | eff) Unit

foreign import resume  :: ∀ eff. AudioContext -> Eff (audio :: AUDIO | eff) Unit

-- | Closes the audio context, releasing any system audio resources used by the BaseAudioContext.
-- | todo: close :: ..

-- | A property used to set the EventHandler for an event that is dispatched to BaseAudioContext
-- | when the state of the AudioContext has changed (i.e. when the corresponding promise would have resolved).
-- | todo: onstatechange :: ..

-- | Asynchronously decodes the audio file data contained in the ArrayBuffer.
foreign import decodeAudioData
  :: ∀ eff f.
     AudioContext
  -> ArrayBuffer
  -> (AudioBuffer -> Eff (audio :: AUDIO | eff) Unit) -- sucesss
  -> (String -> Eff (console :: CONSOLE | eff) Unit) -- failure
  -> (Eff (audio :: AUDIO | f) Unit)

-- | Creates an AudioBufferSourceNode.
foreign import createBufferSource
  :: ∀ eff. AudioContext
  -> (Eff (audio :: AUDIO | eff) AudioBufferSourceNode)

-- | Create a GainNode.
foreign import createGain
  :: ∀ eff. AudioContext
  -> (Eff (audio :: AUDIO | eff) GainNode)

-- | Create an OscillatorNode
foreign import createOscillator
  :: ∀ eff. AudioContext
  -> (Eff (audio :: AUDIO | eff) OscillatorNode)
