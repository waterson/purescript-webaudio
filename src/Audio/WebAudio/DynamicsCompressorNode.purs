module Audio.WebAudio.DynamicsCompressorNode where

import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, DynamicsCompressorNode, AUDIO)
import Audio.WebAudio.Utils (unsafeGetProp)

foreign import threshold
  :: forall eff. DynamicsCompressorNode -> (Eff (audio :: AUDIO | eff) AudioParam)

foreign import knee
  :: forall eff. DynamicsCompressorNode -> (Eff (audio :: AUDIO | eff) AudioParam)

foreign import ratio
  :: forall eff. DynamicsCompressorNode -> (Eff (audio :: AUDIO | eff) AudioParam)

-- | reduction is read-only
reduction :: ∀ eff. DynamicsCompressorNode  -> (Eff (audio :: AUDIO | eff) Number)
reduction n = unsafeGetProp "reduction" n

foreign import attack
  :: forall eff. DynamicsCompressorNode -> (Eff (audio :: AUDIO | eff) AudioParam)

foreign import release
  :: forall eff. DynamicsCompressorNode -> (Eff (audio :: AUDIO | eff) AudioParam)
