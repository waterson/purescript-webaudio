module Audio.WebAudio.DynamicsCompressorNode where

import Effect (Effect)
import Audio.WebAudio.Types (AudioParam, DynamicsCompressorNode)
import Audio.WebAudio.Utils (unsafeGetProp)

foreign import threshold
  :: DynamicsCompressorNode -> Effect AudioParam

foreign import knee
  :: DynamicsCompressorNode -> Effect AudioParam

foreign import ratio
  :: DynamicsCompressorNode -> Effect AudioParam

-- | reduction is read-only
reduction :: DynamicsCompressorNode  -> Effect Number
reduction n = unsafeGetProp "reduction" n

foreign import attack
  :: DynamicsCompressorNode -> Effect AudioParam

foreign import release
  :: DynamicsCompressorNode -> Effect AudioParam
