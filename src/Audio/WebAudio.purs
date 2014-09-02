module Audio.WebAudio where

import Control.Monad.Eff

-- XXX here is a dependency that we may not want to have...
import Data.DOM.Simple.Types
import Data.Maybe

foreign import data WebAudio :: !
foreign import data WebAudioContext :: *
foreign import data OscillatorNode :: *
foreign import data DestinationNode :: *
foreign import data MediaElementAudioSourceNode :: *
foreign import data AudioBuffer :: *
foreign import data AudioBufferSourceNode :: *

class AudioNode n

foreign import makeWebAudioContext
  "function makeWebAudioContext() { \n\
  \  return new (window.AudioContext || window.webkitAudioContext)(); \n\
  \}" :: forall wau eff. (Eff (wau :: WebAudio | eff) WebAudioContext)

foreign import createOscillator
  "function createOscillator(ctx) { \n\
  \  return function() { \n\
  \    return ctx.createOscillator(); \n\
  \  }; \n\
  \}" :: forall wau eff. WebAudioContext -> (Eff (wau :: WebAudio | eff) OscillatorNode)

foreign import createMediaElementSource
  "function createMediaElementSource(ctx) { \n\
  \  return function(elt) { \n\
  \    return function() { \n\
  \      return ctx.createMediaElementSource(elt); \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau dom eff. WebAudioContext -> HTMLElement -> (Eff (wau :: WebAudio, dom :: DOM | eff) MediaElementAudioSourceNode)

destination :: forall wau eff. WebAudioContext -> (Eff (wau :: WebAudio | eff) DestinationNode)
destination = unsafeGetProp "destination"

foreign import currentTime
  "function currentTime(cx) { \n\
  \  return function() { \n\
  \    return cx.currentTime; \n\
  \  }; \n\
  \}" :: forall wau eff. WebAudioContext -> (Eff (wau :: WebAudio | eff) Number)

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
  \}" :: forall wau e f. WebAudioContext -> String -> (Maybe AudioBuffer -> Eff (wau :: WebAudio | e) Unit) -> (Eff (wau :: WebAudio | f) Unit)

foreign import createBufferSource
  "function createBufferSource(cx) { \n\
  \  return function() { \n\
  \    return cx.createBufferSource(); \n\
  \  }; \n\
  \}" :: forall wau eff. WebAudioContext -> (Eff (wau :: WebAudio | eff) AudioBufferSourceNode)

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
  \}" :: forall m n wau eff. (AudioNode m, AudioNode n) => m -> n -> (Eff (wau :: WebAudio | eff) Unit)

-- AudioBufferSourceNode

foreign import setBuffer
  "function setBuffer(src) { \n\
  \  return function(buf) { \n\
  \    return function() { \n\
  \      src.buffer = buf; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. AudioBufferSourceNode -> AudioBuffer -> (Eff (wau :: WebAudio | eff) Unit)

foreign import startBufferSource
  "function startBufferSource(src) { \n\
  \  return function(when) { \n\
  \    return function() { \n\
  \      src.start(when); \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. AudioBufferSourceNode -> Number -> (Eff (wau :: WebAudio | eff) Unit)

instance audioNodeAudioBufferSourceNode :: AudioNode AudioBufferSourceNode

-- DestinationNode

instance audioNodeDestinationNode :: AudioNode DestinationNode

-- OscillatorNode

data OscillatorType = Sine | Square | Sawtooth | Triangle | Custom

instance oscillatorTypeShow :: Show OscillatorType where
    show Sine     = "sine"
    show Square   = "square"
    show Sawtooth = "sawtooth"
    show Triangle = "triangle"
    show Custom   = "custom"

readOscillatorType :: String -> OscillatorType
readOscillatorType "sine"     = Sine
readOscillatorType "square"   = Square
readOscillatorType "sawtooth" = Sawtooth
readOscillatorType "triangle" = Triangle
readOscillatorType "custom"   = Custom

frequency :: forall wau eff. OscillatorNode -> (Eff (wau :: WebAudio | eff) Number)
frequency = unsafeGetAudioParamValue "frequency"

setFrequency :: forall wau eff. OscillatorNode -> Number -> (Eff (wau :: WebAudio | eff) Unit)
setFrequency = unsafeSetAudioParamValue "frequency"

oscillatorType :: forall wau eff. OscillatorNode -> (Eff (wau :: WebAudio | eff) OscillatorType)
oscillatorType n = readOscillatorType <$> unsafeGetProp "type" n

setOscillatorType :: forall wau eff. OscillatorNode -> OscillatorType -> (Eff (wau :: WebAudio | eff) Unit)
setOscillatorType n t = unsafeSetProp "type" n $ show t

foreign import startOscillator
  "function startOscillator(n) { \n\
  \  return function(when) { \n\
  \    return function() { \n\
  \      return n[n.start ? 'start' : 'noteOn'](when); \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. OscillatorNode -> Number -> (Eff (wau :: WebAudio | eff) Unit)

foreign import stopOscillator
  "function stopOscillator(n) { \n\
  \  return function(when) { \n\
  \    return function() { \n\
  \      return n[n.stop ? 'stop' : 'noteOff'](when); \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall wau eff. OscillatorNode -> Number -> (Eff (wau :: WebAudio | eff) Unit)

instance audioNodeOscillatorNode :: AudioNode OscillatorNode

-- MediaElementAudioSourceNode

instance audioNodeMediaElementAudioSourceNode :: AudioNode MediaElementAudioSourceNode

-- Helpers

foreign import unsafeSetProp
  "function unsafeSetProp(prop) { \n\
  \  return function(obj) { \n\
  \    return function(value) { \n\
  \      return function() { \n\
  \        obj[prop] = value; \n\
  \      }; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall obj val eff. String -> obj -> val -> (Eff eff Unit)

foreign import unsafeGetProp
  "function unsafeGetProp(prop) { \n\
  \  return function(obj) { \n\
  \    return function() { \n\
  \      return obj[prop]; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall obj val eff. String -> obj -> (Eff eff val)

foreign import unsafeSetAudioParamValue
  "function unsafeSetAudioParamValue(prop) { \n\
  \  return function(obj) { \n\
  \    return function(value) { \n\
  \      return function() { \n\
  \        obj[prop].value = value; \n\
  \      }; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall obj val eff. String -> obj -> val -> (Eff eff Unit)

foreign import unsafeGetAudioParamValue
  "function unsafeGetAudioParamValue(prop) { \n\
  \  return function(obj) { \n\
  \    return function() { \n\
  \      return obj[prop].value; \n\
  \    }; \n\
  \  }; \n\
  \}" :: forall obj val eff. String -> obj -> (Eff eff val)

