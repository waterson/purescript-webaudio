module Audio.WebAudio.OscillatorNode where

import Control.Monad.Eff
import Audio.WebAudio.Types
import Audio.WebAudio.Utils

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
