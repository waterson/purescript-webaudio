module Audio.WebAudio.AudioBufferSourceNode where

import Control.Monad.Eff
import Audio.WebAudio.Types

foreign import setBuffer
  "function setBuffer(buf) { \n\
  \  return function(src) { \n\
  \    return function() { \n\
  \      src.buffer = buf; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. AudioBuffer
      -> AudioBufferSourceNode
      -> (Eff (wau :: WebAudio | eff) Unit)

foreign import startBufferSource
  "function startBufferSource(when) { \n\
  \  return function(src) { \n\
  \    return function() { \n\
  \      src.start(when); \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. Number
      -> AudioBufferSourceNode
      -> (Eff (wau :: WebAudio | eff) Unit)

instance audioNodeAudioBufferSourceNode :: AudioNode AudioBufferSourceNode
