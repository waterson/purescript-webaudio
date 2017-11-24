module Audio.WebAudio.Utils
  ( unsafeGetProp, unsafeSetProp, unsafeConnectParam) where

import Prelude
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (class AudioNode, WebAudio)

foreign import unsafeSetProp :: forall obj val eff. String -> obj -> val -> (Eff eff Unit)
foreign import unsafeGetProp :: forall obj val eff. String -> obj -> (Eff eff val)

-- | experimental
-- | the String parameter names an audio parameter on the target node, n
-- | this function connects this audio parameter to node m
-- |
-- | it seems we need to do this as an atomic operation
-- | If we have separate monadic functions to get the audio parameter
-- | and to connect a node to it, then it fails to work.
-- | The Web-Audio JavaScript requires the original parameter, not a copy
-- |
-- | This is very unsafe.  The parameter must exist on the target.
foreign import unsafeConnectParam  :: ∀ m n eff. AudioNode m => AudioNode n => m
  -> n
  -> String
  -> (Eff (wau :: WebAudio | eff) Unit)
