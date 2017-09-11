module Audio.WebAudio.AudioParam
  (setValue, getValue, setValueAtTime
  , linearRampToValueAtTime, exponentialRampToValueAtTime, cancelScheduledValues
  ) where

import Prelude
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, WebAudio)

foreign import setValue
  :: ∀ eff. Number -> AudioParam -> (Eff (wau :: WebAudio | eff) Unit)

-- foreign import setValue
--   :: ∀ eff. AudioParam -> Number -> (Eff (wau :: WebAudio | eff) Unit)

foreign import getValue
  :: ∀ eff. AudioParam -> (Eff (wau :: WebAudio | eff) Number)

foreign import setValueAtTime
  :: ∀ eff. Number -> Number -> AudioParam -> (Eff (wau :: WebAudio | eff) Number)

foreign import linearRampToValueAtTime
  :: ∀ eff. Number -> Number -> AudioParam -> (Eff (wau :: WebAudio | eff) Number)

foreign import exponentialRampToValueAtTime
  :: ∀ eff. Number -> Number -> AudioParam -> (Eff (wau :: WebAudio | eff) Number)

foreign import cancelScheduledValues
  :: ∀ eff. Number -> AudioParam -> (Eff (wau :: WebAudio | eff) Number)
