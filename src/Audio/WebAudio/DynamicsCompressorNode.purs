module Audio.WebAudio.DynamicsCompressorNode where

import Prelude (Unit)
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, DynamicsCompressorNode, WebAudio)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)

foreign import threshold
  :: forall eff. DynamicsCompressorNode -> (Eff (wau :: WebAudio | eff) AudioParam)

foreign import knee
  :: forall eff. DynamicsCompressorNode -> (Eff (wau :: WebAudio | eff) AudioParam)

foreign import ratio
  :: forall eff. DynamicsCompressorNode -> (Eff (wau :: WebAudio | eff) AudioParam)

-- | reduction is read-only
reduction :: ∀ eff. DynamicsCompressorNode  -> (Eff (wau :: WebAudio | eff) Number)
reduction n = unsafeGetProp "reduction" n

foreign import attack
  :: forall eff. DynamicsCompressorNode -> (Eff (wau :: WebAudio | eff) AudioParam)

foreign import release
  :: forall eff. DynamicsCompressorNode -> (Eff (wau :: WebAudio | eff) AudioParam)
