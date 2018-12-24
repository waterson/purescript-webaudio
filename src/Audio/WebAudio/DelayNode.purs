module Audio.WebAudio.DelayNode (delayTime) where

import Effect (Effect)
import Audio.WebAudio.Types (AudioParam, DelayNode)
import Audio.WebAudio.Utils (unsafeGetProp)

delayTime :: DelayNode -> Effect AudioParam
delayTime = unsafeGetProp "delayTime"
