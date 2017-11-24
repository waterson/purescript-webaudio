module Audio.WebAudio.Utils
  ( unsafeGetProp, unsafeSetProp, unsafeConnectParam) where

import Prelude
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (class AudioNode, WebAudio)

foreign import unsafeSetProp :: forall obj val eff. String -> obj -> val -> (Eff eff Unit)
foreign import unsafeGetProp :: forall obj val eff. String -> obj -> (Eff eff val)

-- |  experimental
-- |  String names an audio parameter on the target node, n
-- |  connect this audio parameter to the source node, m
-- |  this is exceptionally unsafe!
foreign import unsafeConnectParam  :: ∀ m n eff. AudioNode m => AudioNode n => m
  -> n
  -> String
  -> (Eff (wau :: WebAudio | eff) Unit)
