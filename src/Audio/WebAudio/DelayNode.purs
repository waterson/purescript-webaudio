module Audio.WebAudio.DelayNode (delayTime) where

import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, DelayNode, AUDIO)
import Audio.WebAudio.Utils (unsafeGetProp)

delayTime :: ∀ eff. DelayNode -> (Eff (audio :: AUDIO | eff) AudioParam)
delayTime = unsafeGetProp "delayTime"
