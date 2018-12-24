module Audio.WebAudio.Oscillator
  ( OscillatorType(..), readOscillatorType, frequency, detune, setFrequency
  , setDetune, oscillatorType, setOscillatorType, startOscillator
  , stopOscillator) where

import Prelude
import Effect (Effect)
import Audio.WebAudio.Types (AudioParam, OscillatorNode)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)
import Audio.WebAudio.AudioParam (setValue)

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
readOscillatorType _          = Sine

derive instance eqOscillatorType :: Eq OscillatorType
derive instance ordOscillatorType :: Ord OscillatorType

frequency :: OscillatorNode -> Effect AudioParam
frequency = unsafeGetProp "frequency"

setFrequency :: Number -> OscillatorNode -> Effect Unit
setFrequency num node =
  setValue num =<< frequency node

detune :: OscillatorNode -> Effect AudioParam
detune = unsafeGetProp "detune"

setDetune :: Number -> OscillatorNode -> Effect Unit
setDetune num node =
  setValue num =<< detune node

oscillatorType :: OscillatorNode -> Effect OscillatorType
oscillatorType n = readOscillatorType <$> unsafeGetProp "type" n

setOscillatorType :: OscillatorType -> OscillatorNode -> Effect Unit
setOscillatorType t n = unsafeSetProp "type" n $ show t

foreign import startOscillator :: Number -> OscillatorNode -> Effect Unit
foreign import stopOscillator :: Number -> OscillatorNode -> Effect Unit
