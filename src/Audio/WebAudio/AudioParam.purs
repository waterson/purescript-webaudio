module Audio.WebAudio.AudioParam
  (setTargetAtTime, setValueAtTime, getValue, setValue
  , linearRampToValueAtTime, exponentialRampToValueAtTime, cancelScheduledValues
  , Value, Seconds
  ) where

import Prelude (Unit)
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, AUDIO)

-- | Type synonymn for the value (e.g., Volume) of an AudioParam
type Value = Number

-- | Type synomymn for time (in seconds)
type Seconds = Number

foreign import setValue
  :: ∀ eff. Value -> AudioParam -> (Eff (wau :: AUDIO | eff) Unit)

foreign import setValueAtTime
  :: ∀ eff. Value -> Seconds -> AudioParam -> (Eff (wau :: AUDIO | eff) Value)

foreign import setTargetAtTime
  :: ∀ eff. Value -> Seconds -> Seconds -> AudioParam -> (Eff (wau :: AUDIO | eff) Value)

foreign import getValue
  :: ∀ eff. AudioParam -> (Eff (wau :: AUDIO | eff) Value)

foreign import linearRampToValueAtTime
  :: ∀ eff. Value -> Seconds -> AudioParam -> (Eff (wau :: AUDIO | eff) Value)

foreign import exponentialRampToValueAtTime
  :: ∀ eff. Value -> Seconds -> AudioParam -> (Eff (wau :: AUDIO | eff) Value)

foreign import cancelScheduledValues
  :: ∀ eff. Value -> AudioParam -> (Eff (wau :: AUDIO | eff) Value)
