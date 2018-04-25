module Audio.WebAudio.AudioParam
  (setTargetAtTime, setValueAtTime, getValue, setValue
  , linearRampToValueAtTime, exponentialRampToValueAtTime, cancelScheduledValues
  ) where

import Prelude (Unit)
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, AUDIO, Value, Seconds)

foreign import setValue
  :: ∀ eff. Value -> AudioParam -> (Eff (audio :: AUDIO | eff) Unit)

foreign import setValueAtTime
  :: ∀ eff. Value -> Seconds -> AudioParam -> (Eff (audio :: AUDIO | eff) Value)

foreign import setTargetAtTime
  :: ∀ eff. Value -> Seconds -> Seconds -> AudioParam -> (Eff (audio :: AUDIO | eff) Value)

foreign import getValue
  :: ∀ eff. AudioParam -> (Eff (audio :: AUDIO | eff) Value)

foreign import linearRampToValueAtTime
  :: ∀ eff. Value -> Seconds -> AudioParam -> (Eff (audio :: AUDIO | eff) Value)

foreign import exponentialRampToValueAtTime
  :: ∀ eff. Value -> Seconds -> AudioParam -> (Eff (audio :: AUDIO | eff) Value)

foreign import cancelScheduledValues
  :: ∀ eff. Value -> AudioParam -> (Eff (audio :: AUDIO | eff) Value)
