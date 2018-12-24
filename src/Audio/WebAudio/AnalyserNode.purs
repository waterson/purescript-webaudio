module Audio.WebAudio.AnalyserNode
  (fftSize, frequencyBinCount, setFftSize, setFrequencyBinCount,
    minDecibels, setMinDecibels, maxDecibels, setMaxDecibels,
    smoothingTimeConstant, setSmoothingTimeConstant,
    getFloatFrequencyData, getByteFrequencyData, getFloatTimeDomainData,
    getByteTimeDomainData ) where

import Prelude (Unit)
import Data.ArrayBuffer.Types (ByteLength, Uint8Array, Float32Array)
import Audio.WebAudio.Types (AnalyserNode)
import Effect (Effect)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)


-- | The fftSize property's value must be a non-zero power of 2 in a range
-- | from 32 to 32768; its default value is 2048.
-- | If its value is not a power of 2, or it is outside the specified range,
-- | the exception INDEX_SIZE_ERR is thrown.
fftSize :: AnalyserNode -> Effect ByteLength
fftSize n = unsafeGetProp "fftSize" n

setFftSize :: ByteLength -> AnalyserNode -> Effect Unit
setFftSize size n = unsafeSetProp "fftSize" n size

frequencyBinCount :: AnalyserNode -> Effect ByteLength
frequencyBinCount n = unsafeGetProp "frequencyBinCount" n

setFrequencyBinCount :: ByteLength -> AnalyserNode -> Effect Unit
setFrequencyBinCount count n = unsafeSetProp "frequencyBinCount" n count

minDecibels :: AnalyserNode -> Effect Number
minDecibels n = unsafeGetProp "minDecibels" n

setMinDecibels :: Number -> AnalyserNode -> Effect Unit
setMinDecibels db n = unsafeSetProp "minDecibels" n db

maxDecibels :: AnalyserNode -> Effect Number
maxDecibels n = unsafeGetProp "maxDecibels" n

setMaxDecibels :: Number -> AnalyserNode -> Effect Unit
setMaxDecibels db n = unsafeSetProp "maxDecibels" n db

smoothingTimeConstant :: AnalyserNode -> Effect Number
smoothingTimeConstant n = unsafeGetProp "smoothingTimeConstant" n

setSmoothingTimeConstant :: Number -> AnalyserNode -> Effect Unit
setSmoothingTimeConstant tc n = unsafeSetProp "smoothingTimeConstant" n tc



foreign import getFloatFrequencyData :: AnalyserNode -> Float32Array -> Effect Unit

foreign import getByteFrequencyData :: AnalyserNode -> Uint8Array -> Effect Unit

foreign import getFloatTimeDomainData :: AnalyserNode -> Float32Array -> Effect Unit

foreign import getByteTimeDomainData :: AnalyserNode -> Uint8Array -> Effect Unit
