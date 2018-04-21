module Audio.WebAudio.Utils
  ( unsafeGetProp, unsafeSetProp) where

import Prelude
import Control.Monad.Eff (Eff)

foreign import unsafeSetProp :: forall obj val eff. String -> obj -> val -> (Eff eff Unit)
foreign import unsafeGetProp :: forall obj val eff. String -> obj -> (Eff eff val)
