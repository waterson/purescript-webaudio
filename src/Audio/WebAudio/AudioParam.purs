module Audio.WebAudio.AudioParam
  (setTargetAtTime, setValueAtTime, getValue, setValue
  , linearRampToValueAtTime, exponentialRampToValueAtTime, cancelScheduledValues
  ) where

import Prelude (Unit)
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, AUDIO)

foreign import setValue
  :: ∀ eff. Number -> AudioParam -> (Eff (wau :: AUDIO | eff) Unit)

foreign import setValueAtTime
  :: ∀ eff. Number -> Number -> AudioParam -> (Eff (wau :: AUDIO | eff) Number)

foreign import setTargetAtTime
  :: ∀ eff. Number -> Number -> Number -> AudioParam -> (Eff (wau :: AUDIO | eff) Number)

foreign import getValue
  :: ∀ eff. AudioParam -> (Eff (wau :: AUDIO | eff) Number)


foreign import linearRampToValueAtTime
  :: ∀ eff. Number -> Number -> AudioParam -> (Eff (wau :: AUDIO | eff) Number)

foreign import exponentialRampToValueAtTime
  :: ∀ eff. Number -> Number -> AudioParam -> (Eff (wau :: AUDIO | eff) Number)

foreign import cancelScheduledValues
  :: ∀ eff. Number -> AudioParam -> (Eff (wau :: AUDIO | eff) Number)
