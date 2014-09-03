module Audio.WebAudio.AudioContext where

import Control.Monad.Eff
import Data.Maybe
import Audio.WebAudio.Types
import Audio.WebAudio.Utils

foreign import makeAudioContext
  "function makeAudioContext() { \n\
  \  return new (window.AudioContext || window.webkitAudioContext)(); \n\
  \}" :: forall wau eff. (Eff (wau :: WebAudio | eff) AudioContext)

foreign import createOscillator
  "function createOscillator(ctx) { \n\
  \  return function() { \n\
  \    return ctx.createOscillator(); \n\
  \  }; \n\
  \}" :: forall wau eff. AudioContext
      -> (Eff (wau :: WebAudio | eff) OscillatorNode)

foreign import createMediaElementSource
  "function createMediaElementSource(ctx) { \n\
  \  return function(elt) { \n\
  \    return function() { \n\
  \      return ctx.createMediaElementSource(elt); \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall elt wau dom eff. AudioContext
      -> elt -- |^ a DOM element from which to construct the source node
      -> (Eff (wau :: WebAudio | eff) MediaElementAudioSourceNode)

destination :: forall wau eff. AudioContext
            -> (Eff (wau :: WebAudio | eff) DestinationNode)

destination = unsafeGetProp "destination"

foreign import currentTime
  "function currentTime(cx) { \n\
  \  return function() { \n\
  \    return cx.currentTime; \n\
  \  }; \n\
  \}" :: forall wau eff. AudioContext
      -> (Eff (wau :: WebAudio | eff) Number)

foreign import decodeAudioData
  "function decodeAudioData(cx) { \n\
  \  return function(audioData) { \n\
  \    return function(cb) { \n\
  \      return function() { \n\
  \        cx.decodeAudioData(audioData, \n\
  \          function(data) { \n\
  \            cb(new PS.Data_Maybe.Just(data))(); }, \n\
  \          function() { \n\
  \            cb(PS.Data_Maybe.Nothing.value)(); }); \n\
  \      }; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau e f. AudioContext
      -> String
      -> (Maybe AudioBuffer -> Eff (wau :: WebAudio | e) Unit)
      -> (Eff (wau :: WebAudio | f) Unit)

foreign import createBufferSource
  "function createBufferSource(cx) { \n\
  \  return function() { \n\
  \    return cx.createBufferSource(); \n\
  \  }; \n\
  \}" :: forall wau eff. AudioContext
      -> (Eff (wau :: WebAudio | eff) AudioBufferSourceNode)

-- XXX this is really a method on an AudioNode.

foreign import connect
  "function connect(_) { \n\
  \  return function(_) { \n\
  \    return function(source) { \n\
  \      return function(sink) { \n\
  \        return function() { \n\
  \          source.connect(sink); \n\
  \        }; \n\
  \      }; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall m n wau eff. (AudioNode m, AudioNode n) => m
      -> n
      -> (Eff (wau :: WebAudio | eff) Unit)

