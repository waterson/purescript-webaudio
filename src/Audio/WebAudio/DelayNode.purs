module Audio.WebAudio.DelayNode (delayTime) where

import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, DelayNode, WebAudio)
import Audio.WebAudio.Utils (unsafeGetProp)

delayTime :: ∀ eff. DelayNode -> (Eff (wau :: WebAudio | eff) AudioParam)
delayTime = unsafeGetProp "delayTime"
