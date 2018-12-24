module Audio.WebAudio.AudioParam
  (setTargetAtTime, setValueAtTime, getValue, setValue
  , linearRampToValueAtTime, exponentialRampToValueAtTime, cancelScheduledValues
  ) where

import Prelude (Unit)
import Effect (Effect)
import Audio.WebAudio.Types (AudioParam, Value, Seconds)

foreign import setValue :: Value -> AudioParam -> Effect Unit

foreign import setValueAtTime :: Value -> Seconds -> AudioParam -> Effect Value

foreign import setTargetAtTime
  :: Value -> Seconds -> Seconds -> AudioParam -> Effect Value

foreign import getValue :: AudioParam -> Effect Value

foreign import linearRampToValueAtTime
  :: Value -> Seconds -> AudioParam -> Effect Value

foreign import exponentialRampToValueAtTime
  :: Value -> Seconds -> AudioParam -> Effect Value

foreign import cancelScheduledValues
  :: Value -> AudioParam -> Effect Value
