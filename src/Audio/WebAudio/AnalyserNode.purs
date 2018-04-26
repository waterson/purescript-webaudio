module Audio.WebAudio.AnalyserNode
  (fftSize, frequencyBinCount, setFftSize, setFrequencyBinCount,
    minDecibels, setMinDecibels, maxDecibels, setMaxDecibels,
    smoothingTimeConstant, setSmoothingTimeConstant,
    getFloatFrequencyData, getByteFrequencyData, getFloatTimeDomainData,
    getByteTimeDomainData ) where

import Prelude (Unit)
import Data.ArrayBuffer.Types (ByteLength, Uint8Array, Float32Array)
import Audio.WebAudio.Types (AnalyserNode, AUDIO)
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)


-- | The fftSize property's value must be a non-zero power of 2 in a range
-- | from 32 to 32768; its default value is 2048.
-- | If its value is not a power of 2, or it is outside the specified range,
-- | the exception INDEX_SIZE_ERR is thrown.
fftSize :: ∀ eff. AnalyserNode -> (Eff (audio :: AUDIO | eff) ByteLength)
fftSize n = unsafeGetProp "fftSize" n

setFftSize :: ∀ eff. ByteLength -> AnalyserNode -> (Eff (audio :: AUDIO | eff) Unit)
setFftSize size n = unsafeSetProp "fftSize" n size

frequencyBinCount :: ∀ eff. AnalyserNode -> (Eff (audio :: AUDIO | eff) ByteLength)
frequencyBinCount n = unsafeGetProp "frequencyBinCount" n

setFrequencyBinCount :: ∀ eff. ByteLength -> AnalyserNode -> (Eff (audio :: AUDIO | eff) Unit)
setFrequencyBinCount count n = unsafeSetProp "frequencyBinCount" n count

minDecibels :: ∀ eff. AnalyserNode -> (Eff (audio :: AUDIO | eff) Number)
minDecibels n = unsafeGetProp "minDecibels" n

setMinDecibels :: ∀ eff. Number -> AnalyserNode -> (Eff (audio :: AUDIO | eff) Unit)
setMinDecibels db n = unsafeSetProp "minDecibels" n db

maxDecibels :: ∀ eff. AnalyserNode -> (Eff (audio :: AUDIO | eff) Number)
maxDecibels n = unsafeGetProp "maxDecibels" n

setMaxDecibels :: ∀ eff. Number -> AnalyserNode -> (Eff (audio :: AUDIO | eff) Unit)
setMaxDecibels db n = unsafeSetProp "maxDecibels" n db

smoothingTimeConstant :: ∀ eff. AnalyserNode -> (Eff (audio :: AUDIO | eff) Number)
smoothingTimeConstant n = unsafeGetProp "smoothingTimeConstant" n

setSmoothingTimeConstant :: ∀ eff. Number -> AnalyserNode -> (Eff (audio :: AUDIO | eff) Unit)
setSmoothingTimeConstant tc n = unsafeSetProp "smoothingTimeConstant" n tc



foreign import getFloatFrequencyData :: ∀ eff. AnalyserNode -> Float32Array -> (Eff (audio :: AUDIO | eff) Unit)

foreign import getByteFrequencyData :: ∀ eff. AnalyserNode -> Uint8Array -> (Eff (audio :: AUDIO | eff) Unit)

foreign import getFloatTimeDomainData :: ∀ eff. AnalyserNode -> Float32Array -> (Eff (audio :: AUDIO | eff) Unit)

foreign import getByteTimeDomainData :: ∀ eff. AnalyserNode -> Uint8Array -> (Eff (audio :: AUDIO | eff) Unit)
