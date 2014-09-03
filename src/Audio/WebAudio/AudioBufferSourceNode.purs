module Audio.WebAudio.AudioBufferSourceNode where

import Control.Monad.Eff
import Audio.WebAudio.Types

foreign import setBuffer
  "function setBuffer(src) { \n\
  \  return function(buf) { \n\
  \    return function() { \n\
  \      src.buffer = buf; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. AudioBufferSourceNode
      -> AudioBuffer
      -> (Eff (wau :: WebAudio | eff) Unit)

foreign import startBufferSource
  "function startBufferSource(src) { \n\
  \  return function(when) { \n\
  \    return function() { \n\
  \      src.start(when); \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. AudioBufferSourceNode
      -> Number
      -> (Eff (wau :: WebAudio | eff) Unit)

instance audioNodeAudioBufferSourceNode :: AudioNode AudioBufferSourceNode
