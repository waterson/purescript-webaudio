module Audio.WebAudio.AnalyserNode
  (fftSize, frequencyBinCount, setFftSize, setFrequencyBinCount,
    minDecibels, setMinDecibels, maxDecibels, setMaxDecibels, 
    getFloatFrequencyData, getByteFrequencyData, getFloatTimeDomainData,
    getByteTimeDomainData ) where

import Prelude (Unit)
import Data.ArrayBuffer.Types (ByteLength, Uint8Array, Float32Array)
import Audio.WebAudio.Types (AnalyserNode, WebAudio)
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)


-- | The fftSize property's value must be a non-zero power of 2 in a range
-- | from 32 to 32768; its default value is 2048.
-- | If its value is not a power of 2, or it is outside the specified range,
-- | the exception INDEX_SIZE_ERR is thrown.
fftSize :: ∀ eff. AnalyserNode -> (Eff (wau :: WebAudio | eff) ByteLength)
fftSize n = unsafeGetProp "fftSize" n

setFftSize :: ∀ eff. ByteLength -> AnalyserNode -> (Eff (wau :: WebAudio | eff) Unit)
setFftSize size n = unsafeSetProp "fftSize" n size

frequencyBinCount :: ∀ eff. AnalyserNode -> (Eff (wau :: WebAudio | eff) ByteLength)
frequencyBinCount n = unsafeGetProp "frequencyBinCount" n

setFrequencyBinCount :: ∀ eff. ByteLength -> AnalyserNode -> (Eff (wau :: WebAudio | eff) Unit)
setFrequencyBinCount count n = unsafeSetProp "frequencyBinCount" n count

minDecibels :: ∀ eff. AnalyserNode -> (Eff (wau :: WebAudio | eff) Number)
minDecibels n = unsafeGetProp "minDecibels" n

setMinDecibels :: ∀ eff. Number -> AnalyserNode -> (Eff (wau :: WebAudio | eff) Unit)
setMinDecibels db n = unsafeSetProp "minDecibels" n db

maxDecibels :: ∀ eff. AnalyserNode -> (Eff (wau :: WebAudio | eff) Number)
maxDecibels n = unsafeGetProp "maxDecibels" n

setMaxDecibels :: ∀ eff. Number -> AnalyserNode -> (Eff (wau :: WebAudio | eff) Unit)
setMaxDecibels db n = unsafeSetProp "maxDecibels" n db


foreign import getFloatFrequencyData :: ∀ eff. AnalyserNode -> Float32Array -> (Eff (wau :: WebAudio | eff) Unit)

foreign import getByteFrequencyData :: ∀ eff. AnalyserNode -> Uint8Array -> (Eff (wau :: WebAudio | eff) Unit)

foreign import getFloatTimeDomainData :: ∀ eff. AnalyserNode -> Float32Array -> (Eff (wau :: WebAudio | eff) Unit)

foreign import getByteTimeDomainData :: ∀ eff. AnalyserNode -> Uint8Array -> (Eff (wau :: WebAudio | eff) Unit)
