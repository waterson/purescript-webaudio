module Audio.WebAudio.BiquadFilterNode
  ( BiquadFilterType(..), readBiquadFilterType, filterType, setFilterType
  , filterFrequency, quality, gain) where

import Audio.WebAudio.Types
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)
import Prelude (class Show, class Eq, class Ord, Unit, show, (<$>))

import Effect (Effect)

data BiquadFilterType =
    Lowpass
  | Highpass
  | Bandpass
  | Lowshelf
  | Highshelf
  | Peaking
  | Notch
  | Allpass

instance biquadFilterTypeShow :: Show BiquadFilterType where
    show Lowpass   = "lowpass"
    show Highpass  = "highpass"
    show Bandpass  = "bandpass"
    show Lowshelf  = "lowshelf"
    show Highshelf = "highshelf"
    show Peaking   = "peaking"
    show Notch     = "notch"
    show Allpass   = "allpass"

derive instance eqBiquadFilterType :: Eq BiquadFilterType
derive instance ordBiquadFilterType :: Ord BiquadFilterType


readBiquadFilterType :: String -> BiquadFilterType
readBiquadFilterType "lowpass"   = Lowpass
readBiquadFilterType "highpass"  = Highpass
readBiquadFilterType "bandpass"  = Bandpass
readBiquadFilterType "highshelf" = Highshelf
readBiquadFilterType "peaking"   = Peaking
readBiquadFilterType "notch"     = Notch
readBiquadFilterType "allpass"   = Allpass
readBiquadFilterType _           = Lowpass

filterType :: BiquadFilterNode -> Effect BiquadFilterType
filterType n = readBiquadFilterType <$> unsafeGetProp "type" n

setFilterType :: BiquadFilterType -> BiquadFilterNode -> Effect Unit
setFilterType t n = unsafeSetProp "type" n (show t)

filterFrequency :: BiquadFilterNode -> Effect AudioParam
filterFrequency = unsafeGetProp "frequency"

quality :: BiquadFilterNode -> Effect AudioParam
quality = unsafeGetProp "Q"

foreign import gain
  :: BiquadFilterNode -> Effect AudioParam
