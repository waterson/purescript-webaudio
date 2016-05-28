module Audio.WebAudio.AudioContext where

import Prelude
import Control.Monad.Eff
import Data.Maybe
import Data.DOM.Simple.Ajax
import Audio.WebAudio.Types
import Audio.WebAudio.Utils


foreign import makeAudioContext
  :: forall wau eff. (Eff (wau :: WebAudio | eff) AudioContext)

foreign import createOscillator
  :: forall wau eff. AudioContext
  -> (Eff (wau :: WebAudio | eff) OscillatorNode)

foreign import createGain
  :: forall wau eff. AudioContext
  -> (Eff (wau :: WebAudio | eff) GainNode)

foreign import createMediaElementSource
  :: forall elt wau dom eff. AudioContext
  -> elt -- |^ a DOM element from which to construct the source node
  -> (Eff (wau :: WebAudio | eff) MediaElementAudioSourceNode)

destination :: forall wau eff. AudioContext
            -> (Eff (wau :: WebAudio | eff) DestinationNode)

destination = unsafeGetProp "destination"

foreign import currentTime
  :: forall wau eff. AudioContext
  -> (Eff (wau :: WebAudio | eff) Number)

foreign import decodeAudioData
  :: forall wau e f. AudioContext
  -> ArrayBuffer
  -> (Maybe AudioBuffer -> Eff (wau :: WebAudio | e) Unit)
  -> (Eff (wau :: WebAudio | f) Unit)

foreign import createBufferSource
  :: forall wau eff. AudioContext
  -> (Eff (wau :: WebAudio | eff) AudioBufferSourceNode)

-- XXX this is really a method on an AudioNode.

foreign import connect
  :: forall m n wau eff. (AudioNode m, AudioNode n) => m
  -> n
  -> (Eff (wau :: WebAudio | eff) Unit)

