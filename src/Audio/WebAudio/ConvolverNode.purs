module Audio.WebAudio.ConvolverNode (setBuffer, normalize, isNormalized) where

import Prelude (Unit)
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioBuffer, ConvolverNode, WebAudio)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)

foreign import setBuffer
  :: ∀ eff. AudioBuffer
  -> ConvolverNode
  -> (Eff (wau :: WebAudio | eff) Unit)

normalize :: ∀ eff. Boolean -> ConvolverNode -> (Eff (wau :: WebAudio | eff) Unit)
normalize l n = unsafeSetProp "normalize" n l

isNormalized :: ∀ eff. ConvolverNode -> (Eff (wau :: WebAudio | eff) Boolean)
isNormalized = unsafeGetProp "normalize"
